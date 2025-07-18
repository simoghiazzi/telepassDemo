import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghiazzi/constants/colors.dart';
import 'package:ghiazzi/constants/themes.dart';
import 'package:ghiazzi/viewmodels/courses_view_model.dart';
import 'package:ghiazzi/components/buttons/custom_label.dart';
import 'package:ghiazzi/components/buttons/filtri_button.dart';
import 'package:ghiazzi/components/cards/course_card.dart';

const List<String> courseLabels = [
  'Mostra tutti',
  'Da completare',
  'Obbligatori',
  'Preferiti',
  'In scadenza',
  'Facoltativi',
  'Completati',
  'Scaduti',
];

class CoursesView extends StatefulWidget {
  const CoursesView({super.key});

  @override
  State<CoursesView> createState() => _CoursesViewState();
}

class _CoursesViewState extends State<CoursesView> {
  String selectedLabel = courseLabels[0];

  @override
  void initState() {
    super.initState();
    // Fetch courses on init
    context.read<CoursesViewModel>().getCourses();
  }

  @override
  Widget build(BuildContext context) {
    final palette = Theme.of(context).extension<CustomPalette>()!;
    final appTextStyles =
        Theme.of(context).extension<AppThemeExtension>()!.textStyles;

    return BlocBuilder<CoursesViewModel, CoursesState>(
      builder: (context, state) {
        return BlocBuilder<CoursesViewModel, CoursesState>(
          builder: (context, state) {
            List<Widget> children = [
              CustomLabel(
                labels: courseLabels,
                selected: selectedLabel,
                onSelected: (label) {
                  setState(() => selectedLabel = label);
                },
              ),
              const SizedBox(height: 16),
              Divider(height: 1, thickness: 1, color: palette.primary800),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Corsi", style: appTextStyles.displayM),
                  FiltriButton(
                    onTap: () {
                      // Not shown in the mockup, potentially show a popup with filters
                    },
                  ),
                ],
              ),
              const SizedBox(height: 16),
            ];

            if (state is CoursesLoading) {
              children.add(
                SizedBox(
                  height: 500,
                  child: const Center(child: CircularProgressIndicator()),
                ),
              );
            } else if (state is CoursesError) {
              children.add(Center(child: Text('Errore: \\${state.error}')));
            } else if (state is CoursesSuccess) {
              final filteredCourses =
                  state.courses.where((course) {
                    switch (selectedLabel) {
                      case 'Mostra tutti':
                        return true;
                      case 'Da completare':
                        return course.status != 'completed';
                      case 'Obbligatori':
                        return course.isMandatory == true;
                      case 'Preferiti':
                        return course.isFavorite;
                      case 'In scadenza':
                        if (course.dueDate == null) return false;
                        try {
                          final due = DateTime.parse(course.dueDate!);
                          final now = DateTime.now();
                          final in7days = now.add(const Duration(days: 7));
                          return due.isAfter(now) && due.isBefore(in7days);
                        } catch (_) {
                          return false;
                        }
                      case 'Facoltativi':
                        return course.isOptional == true;
                      case 'Completati':
                        return course.status == 'completed';
                      case 'Scaduti':
                        if (course.dueDate == null) return false;
                        try {
                          final due = DateTime.parse(course.dueDate!);
                          return due.isBefore(DateTime.now());
                        } catch (_) {
                          return false;
                        }
                      default:
                        return true;
                    }
                  }).toList();
              if (filteredCourses.isEmpty) {
                children.add(
                  const Center(child: Text('Nessun corso trovato.')),
                );
              } else {
                children.add(
                  LayoutBuilder(
                    builder: (context, constraints) {
                      int crossAxisCount = 1;
                      double width = constraints.maxWidth;

                      //As usual, we address responsiveness for smaller screens
                      if (width >= 1000) {
                        crossAxisCount = 3;
                      } else if (width >= 600) {
                        crossAxisCount = 2;
                      }

                      return GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 0,
                          vertical: 8,
                        ),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: crossAxisCount,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                          childAspectRatio:
                              crossAxisCount == 1
                                  ? 2.5
                                  : crossAxisCount == 2
                                  ? 2
                                  : 1.5,
                        ),
                        itemCount: filteredCourses.length,
                        itemBuilder: (context, index) {
                          final course = filteredCourses[index];
                          return CourseCard(
                            course: course,
                            onFavouriteToggle: (courseId) {
                              context.read<CoursesViewModel>().toggleFavourite(
                                courseId,
                              );
                            },
                          );
                        },
                      );
                    },
                  ),
                );
              }
            }

            return Column(
              children: [
                Row(
                  children: [
                    Expanded(child: Container()),
                    Expanded(flex: 10, child: Column(children: children)),
                    Expanded(child: Container()),
                  ],
                ),
                Container(
                  color: palette.primary1000,
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset('assets/images/logo.png', height: 32),
                      const SizedBox(height: 8),
                      Text(
                        'Sede legale: Via Laurentina, 449 - 00142 Roma (RM)\nP.IVA 09771701001 - Certificato ISO9001 e ISO27001',
                        style: appTextStyles.paragraphS.copyWith(
                          color: palette.grey400,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
