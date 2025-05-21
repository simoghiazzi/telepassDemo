import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghiazzi/components/knowledge_carousel.dart';
import 'package:ghiazzi/constants/colors.dart';
import 'package:ghiazzi/repositories/knowledge_repository.dart';
import 'package:ghiazzi/viewmodels/knowledge_view_model.dart';
import 'package:ghiazzi/viewmodels/slides_cubit.dart';
import 'package:go_router/go_router.dart';
import '../../components/custom_slider.dart';
import '../../repositories/slides_repository.dart';
import 'package:ghiazzi/components/reels/reel.dart';
import '../../repositories/reels_repository.dart';
import '../../viewmodels/reels_view_model.dart';
import 'package:ghiazzi/constants/themes.dart';
import 'package:ghiazzi/utils/desktop_scroll_behavior.dart';
import 'package:ghiazzi/components/courses_carousel.dart';
import 'package:ghiazzi/viewmodels/courses_view_model.dart';
import 'package:ghiazzi/repositories/courses_repository.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final appTextStyles =
        Theme.of(context).extension<AppThemeExtension>()!.textStyles;
    final palette = Theme.of(context).extension<CustomPalette>()!;

    return Column(
      children: [
        Row(
          children: [
            Expanded(child: Container()),
            Expanded(
              flex: 10,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Le novità del mondo Telepass',
                          style: appTextStyles.headingL,
                          textAlign: TextAlign.left,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Rimani aggiornato su tutte le nostre attività',
                          style: appTextStyles.headingS.copyWith(
                            fontWeight: FontWeight.normal,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        const SizedBox(height: 32),
                      ],
                    ),
                  ),
                  BlocProvider(
                    create:
                        (_) => ReelsViewModel(ReelsRepository())..loadReels(),
                    child: BlocBuilder<ReelsViewModel, ReelsState>(
                      builder: (context, state) {
                        if (state is ReelsLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (state is ReelsLoaded) {
                          return SizedBox(
                            height: 200,
                            child: ScrollConfiguration(
                              behavior: DesktopScrollBehavior(),
                              child: ListView.separated(
                                scrollDirection: Axis.horizontal,
                                itemCount: state.reels.length,
                                separatorBuilder:
                                    (context, i) => const SizedBox(width: 32),
                                itemBuilder:
                                    (context, i) => Reel(reel: state.reels[i]),
                              ),
                            ),
                          );
                        } else {
                          return const Center(
                            child: Text('Errore nel caricamento dei reels'),
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),

            Expanded(child: Container()),
          ],
        ),
        const SizedBox(height: 32),
        Row(
          children: [
            Expanded(child: Container()),
            Expanded(
              flex: 20,
              child: LayoutBuilder(
                builder: (context, constraints) {
                  double width = constraints.maxWidth;
                  //It's useless to show the slider on smaller devices, as the slides are based on images
                  if (width >= 800) {
                    return Column(
                      children: [
                        BlocProvider(
                          create:
                              (_) =>
                                  SlidesViewModel(SlidesRepository())
                                    ..loadSlides(),
                          child: const CustomSlider(),
                        ),
                        const SizedBox(height: 32),
                      ],
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            ),
            Expanded(child: Container()),
          ],
        ),
        Row(
          children: [
            Expanded(child: Container()),
            Expanded(
              flex: 10,
              child: Column(
                children: [
                  const SizedBox(height: 32),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Corsi in evidenza',
                          style: appTextStyles.headingL,
                          textAlign: TextAlign.left,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Lasciati guidare verso un percorso di apprendimento completo',
                          style: appTextStyles.headingS.copyWith(
                            fontWeight: FontWeight.normal,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        const SizedBox(height: 32),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(child: Container()),
          ],
        ),
        const SizedBox(height: 32),
        Row(
          children: [
            Expanded(child: Container()),
            Expanded(
              flex: 20,
              child:
              // Corsi in evidenza - Carousel
              Column(
                children: [
                  BlocProvider(
                    create:
                        (_) =>
                            CoursesViewModel(CoursesRepository())
                              ..getHighlightCourses(),
                    child: const CoursesCarousel(),
                  ),

                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Esplora tutti',
                          style: appTextStyles.headingM.copyWith(
                            color: palette.primary800,
                          ),
                          recognizer:
                              TapGestureRecognizer()
                                ..onTap = () {
                                  context.go('/courses');
                                },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                  Divider(height: 1, thickness: 2, color: palette.grey200),
                  const SizedBox(height: 32),
                ],
              ),
            ),
            Expanded(child: Container()),
          ],
        ),
        Row(
          children: [
            Expanded(child: Container()),
            Expanded(
              flex: 20,
              child:
              // Corsi in evidenza - Carousel
              Column(
                children: [
                  BlocProvider(
                    create:
                        (_) =>
                            KnowledgeViewModel(KnowledgeRepository())
                              ..getKnowledge(),
                    child: const KnowledgeCarousel(),
                  ),

                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Esplora tutti',
                          style: appTextStyles.headingM.copyWith(
                            color: palette.primary800,
                          ),
                          recognizer:
                              TapGestureRecognizer()
                                ..onTap = () {
                                  context.go('/knowledge');
                                },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                  Divider(height: 1, thickness: 2, color: palette.grey200),
                  const SizedBox(height: 32),
                ],
              ),
            ),
            Expanded(child: Container()),
          ],
        ),
      ],
    );
  }
}
