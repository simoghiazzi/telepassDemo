import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghiazzi/constants/colors.dart';
import 'package:ghiazzi/utils/desktop_scroll_behavior.dart';
import 'package:ghiazzi/viewmodels/slides_cubit.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CustomSlider extends StatefulWidget {
  const CustomSlider({super.key});

  @override
  State<CustomSlider> createState() => _CustomSliderState();
}

class _CustomSliderState extends State<CustomSlider> {
  final PageController _controller = PageController();
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      final newIndex = _controller.page?.round() ?? 0;
      if (newIndex != _currentIndex) {
        setState(() {
          _currentIndex = newIndex;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final palette = Theme.of(context).extension<CustomPalette>()!;
    return BlocBuilder<SlidesViewModel, SlidesState>(
      builder: (context, state) {
        if (state is SlidesLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is SlidesLoaded) {
          final slides = state.slides;
          return Column(
            children: [
              SizedBox(
                height: 300,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Left navigation button (fixed)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: CircleAvatar(
                        backgroundColor:
                            _currentIndex == 0
                                ? palette.primary800.withAlpha(128)
                                : palette.primary800,
                        child: IconButton(
                          icon: Icon(
                            Icons.arrow_back_ios_new_rounded,
                            color:
                                _currentIndex == 0
                                    ? palette.grey0.withAlpha(128)
                                    : palette.grey0,
                          ),
                          onPressed:
                              _currentIndex == 0
                                  ? null
                                  : () {
                                    _controller.previousPage(
                                      duration: const Duration(
                                        milliseconds: 300,
                                      ),
                                      curve: Curves.easeInOut,
                                    );
                                  },
                          tooltip: 'Precedente',
                        ),
                      ),
                    ),
                    // Slider
                    Expanded(
                      child: ScrollConfiguration(
                        behavior: DesktopScrollBehavior(),
                        child: PageView.builder(
                          controller: _controller,
                          itemCount: slides.length,
                          onPageChanged: (index) {
                            setState(() {
                              _currentIndex = index;
                            });
                          },
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(24),
                                child: Image.asset(
                                  slides[index],
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    // Right navigation button (fixed)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: CircleAvatar(
                        backgroundColor:
                            _currentIndex == slides.length - 1
                                ? palette.primary800.withAlpha(128)
                                : palette.primary800,
                        child: IconButton(
                          icon: Icon(
                            Icons.arrow_forward_ios_rounded,
                            color:
                                _currentIndex == slides.length - 1
                                    ? palette.grey0.withAlpha(128)
                                    : palette.grey0,
                          ),
                          onPressed:
                              _currentIndex == slides.length - 1
                                  ? null
                                  : () {
                                    _controller.nextPage(
                                      duration: const Duration(
                                        milliseconds: 300,
                                      ),
                                      curve: Curves.easeInOut,
                                    );
                                  },
                          tooltip: 'Prossimo',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              SmoothPageIndicator(
                controller: _controller,
                count: slides.length,
                effect: SwapEffect(
                  dotHeight: 8,
                  dotWidth: 8,
                  activeDotColor: palette.primary900,
                  dotColor: palette.grey400,
                ),
              ),
            ],
          );
        } else {
          return const Center(
            child: Text('Errore nel caricamento degli slide'),
          );
        }
      },
    );
  }
}
