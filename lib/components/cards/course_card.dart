import 'package:flutter/material.dart';
import 'package:ghiazzi/constants/colors.dart';
import 'package:ghiazzi/constants/themes.dart';
import 'package:ghiazzi/models/course_model.dart';

class CourseCard extends StatelessWidget {
  final CourseModel course;
  final VoidCallback? onTap;
  final ValueChanged<int>? onFavouriteToggle;

  const CourseCard({
    super.key,
    required this.course,
    this.onTap,
    this.onFavouriteToggle,
  });

  Color getStatusColor() {
    if (course.status == 'completed') return Colors.green;
    if (course.status == 'due') return Colors.orange;
    return Colors.grey;
  }

  IconData getStatusIcon() {
    if (course.status == 'completed') return Icons.check_circle;
    if (course.status == 'due') return Icons.error_outline;
    return Icons.radio_button_unchecked;
  }

  Color getProgressColor() {
    if (course.status == 'completed') return Colors.green;
    return Colors.blue;
  }

  @override
  Widget build(BuildContext context) {
    final palette = Theme.of(context).extension<CustomPalette>()!;
    final appTextStyles =
        Theme.of(context).extension<AppThemeExtension>()!.textStyles;

    return LayoutBuilder(
      builder: (context, constraints) {
        //Addressing responsiveness for smalle screens/handheld devices
        final screenWidth = MediaQuery.of(context).size.width;
        final isSmallScreen = screenWidth < 400 || constraints.maxWidth < 400;
        final imageWidth = isSmallScreen ? 64.0 : 96.0;
        final contentPadding = isSmallScreen ? 6.0 : 12.0;

        final fontSizeTitle = isSmallScreen ? 16.0 : 20.0;
        final fontSizeCategory = isSmallScreen ? 11.0 : 13.0;
        final fontSizeMeta = isSmallScreen ? 10.0 : 13.0;
        final fontSizeStatus = isSmallScreen ? 10.0 : 14.0;
        final iconSizeMeta = isSmallScreen ? 13.0 : 17.0;
        final iconSizeStatus = isSmallScreen ? 14.0 : 18.0;
        final starSize = isSmallScreen ? 20.0 : 28.0;

        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 3,
          child: Stack(
            children: [
              InkWell(
                onTap: onTap,
                borderRadius: BorderRadius.circular(16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(12),
                            bottomLeft: Radius.circular(12),
                          ),
                          child: SizedBox(
                            width: imageWidth,
                            height: double.infinity,
                            child: Image.asset(
                              course.imageUrl,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(99),
                          ),
                          child: Icon(
                            Icons.play_circle_fill,
                            color:
                                course.status == 'completed'
                                    ? Colors.green
                                    : Theme.of(context).primaryColor,
                            size: isSmallScreen ? 22.0 : 36.0,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: isSmallScreen ? 6 : 16),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(contentPadding),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: isSmallScreen ? 7 : 12,
                                vertical: isSmallScreen ? 2 : 4,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFFFFE066),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Text(
                                course.category,
                                style: appTextStyles.headingS.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: palette.primary1000,
                                  fontSize: fontSizeCategory,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            SizedBox(height: isSmallScreen ? 2 : 8),
                            Wrap(
                              spacing: isSmallScreen ? 6 : 10,
                              crossAxisAlignment: WrapCrossAlignment.center,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      '${course.modulesCount} moduli',
                                      style: appTextStyles.paragraphS.copyWith(
                                        color: palette.grey600,
                                        fontSize: fontSizeMeta,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.emoji_events,
                                      color: palette.grey600,
                                      size: iconSizeMeta,
                                    ),
                                    SizedBox(width: 2),
                                    Text(
                                      '${course.points}P',
                                      style: appTextStyles.paragraphS.copyWith(
                                        color: palette.grey600,
                                        fontSize: fontSizeMeta,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: isSmallScreen ? 2 : 4),
                            Text(
                              course.title,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: appTextStyles.headingM.copyWith(
                                fontWeight: FontWeight.bold,
                                color: palette.primary1000,
                                fontSize: fontSizeTitle,
                              ),
                            ),
                            SizedBox(height: isSmallScreen ? 2 : 6),
                            Row(
                              children: [
                                if (course.status == 'completed' &&
                                    course.dueDate != null) ...[
                                  Icon(
                                    Icons.check_circle,
                                    color: palette.success100,
                                    size: iconSizeStatus,
                                  ),
                                  SizedBox(width: 4),
                                  Flexible(
                                    child: Text(
                                      course.dueDate!,
                                      style: appTextStyles.headingS.copyWith(
                                        color: palette.success100,
                                        fontWeight: FontWeight.bold,
                                        fontSize: fontSizeStatus,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ] else if (course.status == 'due' &&
                                    course.dueDate != null) ...[
                                  Icon(
                                    Icons.error_outline,
                                    color: palette.warning100,
                                    size: iconSizeStatus,
                                  ),
                                  SizedBox(width: 4),
                                  Flexible(
                                    child: Text(
                                      course.dueDate!,
                                      style: appTextStyles.headingS.copyWith(
                                        color: palette.warning100,
                                        fontWeight: FontWeight.bold,
                                        fontSize: fontSizeStatus,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ],
                            ),
                            SizedBox(height: isSmallScreen ? 2 : 8),
                            LinearProgressIndicator(
                              value: course.progress ?? 0,
                              minHeight: isSmallScreen ? 3 : 5,
                              backgroundColor: palette.grey300,
                              color:
                                  course.status == 'completed'
                                      ? palette.success100
                                      : palette.primary800,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: isSmallScreen ? 4 : 10,
                right: isSmallScreen ? 6 : 14,
                child: IconButton(
                  onPressed: () {
                    if (onFavouriteToggle != null) {
                      onFavouriteToggle!(course.id);
                    }
                  },
                  icon: Icon(
                    course.isFavorite ? Icons.star : Icons.star_border,
                    color: palette.primary800,
                    size: starSize,
                  ),
                  hoverColor: Colors.transparent,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
