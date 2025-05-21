import 'package:flutter/material.dart';
import 'package:ghiazzi/constants/colors.dart';
import 'package:ghiazzi/constants/themes.dart';
import 'package:ghiazzi/models/knowledge_model.dart';

class KnowledgeCard extends StatelessWidget {
  final KnowledgeModel knowledge;
  final VoidCallback? onTap;
  final ValueChanged<int>? onFavouriteToggle;

  const KnowledgeCard({
    super.key,
    required this.knowledge,
    this.onTap,
    this.onFavouriteToggle,
  });

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
        final contentPadding = isSmallScreen ? 16.0 : 24.0;

        final fontSizeTitle = isSmallScreen ? 16.0 : 20.0;
        final fontSizeCategory = isSmallScreen ? 11.0 : 13.0;
        final fontSizeDescription = isSmallScreen ? 14.0 : 16.0;
        final starSize = isSmallScreen ? 20.0 : 28.0;

        // Removed fixed cardHeight and SizedBox, let Card expand to fill grid cell
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 3,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(16),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: contentPadding,
                vertical: contentPadding * 0.7,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: isSmallScreen ? 6 : 10,
                      vertical: isSmallScreen ? 1 : 3,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFE066),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      knowledge.category.toLowerCase(),
                      style: appTextStyles.headingS.copyWith(
                        fontWeight: FontWeight.bold,
                        color: palette.primary1000,
                        fontSize: fontSizeCategory,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(height: isSmallScreen ? 16 : 24),
                  Row(
                    children: [
                      Text(
                        knowledge.title.toUpperCase(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: appTextStyles.headingM.copyWith(
                          fontWeight: FontWeight.bold,
                          color: palette.primary1000,
                          fontSize: fontSizeTitle,
                          letterSpacing: 0.4,
                        ),
                      ),
                      Spacer(),
                      IconButton(
                        onPressed: () {
                          if (onFavouriteToggle != null) {
                            onFavouriteToggle!(knowledge.id);
                          }
                        },
                        icon: Icon(
                          knowledge.isFavorite ? Icons.star : Icons.star_border,
                          color: palette.primary800,
                          size: starSize,
                        ),
                        splashRadius: starSize * 0.7,
                        hoverColor: Colors.transparent,
                        padding: EdgeInsets.zero,
                        constraints: BoxConstraints(),
                      ),
                    ],
                  ),
                  SizedBox(height: isSmallScreen ? 16 : 24),
                  Text(
                    knowledge.description,
                    style: appTextStyles.headingS.copyWith(
                      color: palette.primary1000,
                      fontWeight: FontWeight.normal,
                      fontSize: fontSizeDescription * 0.95,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
