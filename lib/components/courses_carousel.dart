import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghiazzi/components/cards/course_card.dart';
import 'package:ghiazzi/constants/colors.dart';
import 'package:ghiazzi/utils/desktop_scroll_behavior.dart';

import 'package:ghiazzi/viewmodels/courses_view_model.dart';

class CoursesCarousel extends StatefulWidget {
  const CoursesCarousel({super.key});

  @override
  State<CoursesCarousel> createState() => _CoursesCarouselState();
}

class _CoursesCarouselState extends State<CoursesCarousel> {
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

    return BlocBuilder<CoursesViewModel, CoursesState>(
      builder: (context, state) {
        if (state is CoursesLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is CoursesSuccess) {
          final courses = state.courses;
          return LayoutBuilder(
            builder: (context, constraints) {
              final total = courses.length;
              const cardWidth = 400.0;
              const padding = 8.0;
              return SizedBox(
                height: 280,
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
                              height: 220,
                              child: ScrollConfiguration(
                                behavior: DesktopScrollBehavior(),
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
                                          child: CourseCard(
                                            course: courses[index],
                                            onFavouriteToggle: (courseId) {
                                              context
                                                  .read<CoursesViewModel>()
                                                  .toggleFavourite(courseId);
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
                    const SizedBox(height: 32),
                  ],
                ),
              );
            },
          );
        } else if (state is CoursesError) {
          return Center(child: Text('Errore nel caricamento dei corsi'));
        }
        return const SizedBox.shrink();
      },
    );
  }
}
