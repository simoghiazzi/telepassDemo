import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghiazzi/components/cards/knowledge_card.dart';
import 'package:ghiazzi/constants/colors.dart';

import 'package:ghiazzi/viewmodels/knowledge_view_model.dart';

class KnowledgeCarousel extends StatefulWidget {
  const KnowledgeCarousel({super.key});

  @override
  State<KnowledgeCarousel> createState() => _KnowledgeCarouselState();
}

class _KnowledgeCarouselState extends State<KnowledgeCarousel> {
  final ScrollController _scrollController = ScrollController();
  int _firstVisible = 0;

  void _scrollTo(int index, double cardWidth, double padding) {
    final offset = index * (cardWidth + 2 * padding);
    _scrollController.animateTo(
      offset,
      duration: const Duration(milliseconds: 300),
      curve: Curves.ease,
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final palette = Theme.of(context).extension<CustomPalette>()!;

    return BlocBuilder<KnowledgeViewModel, KnowledgeState>(
      builder: (context, state) {
        if (state is KnowledgeLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is KnowledgeSuccess) {
          final knowledge = state.knowledge;
          return LayoutBuilder(
            builder: (context, constraints) {
              final total = knowledge.length;
              const cardWidth = 400.0;
              const padding = 8.0;
              return SizedBox(
                height: 200,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: CircleAvatar(
                            backgroundColor:
                                _firstVisible > 0
                                    ? palette.primary800
                                    : palette.primary800.withAlpha(128),
                            child: IconButton(
                              icon: Icon(
                                Icons.arrow_back_ios_new_rounded,
                                color:
                                    _firstVisible > 0
                                        ? palette.grey0
                                        : palette.grey0.withAlpha(128),
                              ),
                              onPressed:
                                  _firstVisible > 0
                                      ? () {
                                        final newIndex = (_firstVisible - 1)
                                            .clamp(0, total - 1);
                                        setState(
                                          () => _firstVisible = newIndex,
                                        );
                                        _scrollTo(newIndex, cardWidth, padding);
                                      }
                                      : null,
                              tooltip: 'Precedente',
                            ),
                          ),
                        ),
                        Expanded(
                          child: NotificationListener<ScrollNotification>(
                            onNotification: (notification) {
                              if (notification is ScrollUpdateNotification ||
                                  notification is ScrollEndNotification) {
                                final first =
                                    (_scrollController.offset /
                                            (cardWidth + 2 * padding))
                                        .round();
                                if (first != _firstVisible) {
                                  setState(() => _firstVisible = first);
                                }
                              }
                              return false;
                            },
                            child: SizedBox(
                              height: 150,
                              child: ListView.builder(
                                controller: _scrollController,
                                scrollDirection: Axis.horizontal,
                                itemCount: total,
                                itemBuilder: (context, index) {
                                  return SizedBox(
                                    width: cardWidth,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: padding,
                                      ),
                                      child: SizedBox(
                                        height: 220,
                                        child: KnowledgeCard(
                                          knowledge: knowledge[index],
                                          onFavouriteToggle: (knowledgeId) {
                                            context
                                                .read<KnowledgeViewModel>()
                                                .toggleFavourite(knowledgeId);
                                          },
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: CircleAvatar(
                            backgroundColor:
                                _firstVisible < total - 1
                                    ? palette.primary800
                                    : palette.primary800.withAlpha(128),
                            child: IconButton(
                              icon: Icon(
                                Icons.arrow_forward_ios_rounded,
                                color:
                                    _firstVisible < total - 1
                                        ? palette.grey0
                                        : palette.grey0.withAlpha(128),
                              ),
                              onPressed:
                                  _firstVisible < total - 1
                                      ? () {
                                        final newIndex = (_firstVisible + 1)
                                            .clamp(0, total - 1);
                                        setState(
                                          () => _firstVisible = newIndex,
                                        );
                                        _scrollTo(newIndex, cardWidth, padding);
                                      }
                                      : null,
                              tooltip: 'Prossimo',
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    if (total > 1)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(3, (index) {
                          final isActive = index == _firstVisible;
                          return GestureDetector(
                            onTap: () {
                              setState(() => _firstVisible = index);
                              _scrollTo(index, cardWidth, padding);
                            },
                            child: Container(
                              margin: const EdgeInsets.symmetric(horizontal: 4),
                              width: 10,
                              height: 10,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color:
                                    isActive
                                        ? palette.primary900
                                        : palette.grey400,
                              ),
                            ),
                          );
                        }),
                      ),
                  ],
                ),
              );
            },
          );
        } else if (state is KnowledgeError) {
          return Center(child: Text('Errore nel caricamento dei corsi'));
        }
        return const SizedBox.shrink();
      },
    );
  }
}
