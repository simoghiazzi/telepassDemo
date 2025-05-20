import 'package:flutter/material.dart';
import 'package:ghiazzi/components/buttons/custom_text_button.dart';
import 'package:ghiazzi/constants/colors.dart';
import 'package:ghiazzi/constants/themes.dart';
import 'package:ghiazzi/models/faq_model.dart';
import 'package:ghiazzi/components/custom_dropdown.dart';

class FaqDrawer extends StatelessWidget {
  final List<FaqModel> faqs;
  final VoidCallback onClose;

  const FaqDrawer({super.key, required this.faqs, required this.onClose});

  @override
  Widget build(BuildContext context) {
    final palette = Theme.of(context).extension<CustomPalette>()!;
    final appTextStyles =
        Theme.of(context).extension<AppThemeExtension>()!.textStyles;

    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 64),
        height: double.infinity,
        decoration: BoxDecoration(
          color: palette.grey0,
          boxShadow: [
            BoxShadow(
              color: palette.grey400,
              blurRadius: 16,
              offset: Offset(-4, 0),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 56.0),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final maxHeight =
                  MediaQuery.of(context).size.height -
                  128; // 64 top + 64 bottom padding
              return ConstrainedBox(
                constraints: BoxConstraints(maxHeight: maxHeight),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.close),
                            onPressed: onClose,
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [Text('FAQ', style: appTextStyles.displayM)],
                      ),
                      const SizedBox(height: 24),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: faqs.length,
                        itemBuilder: (context, index) {
                          return CustomDropdown(
                            title: faqs[index].question,
                            content: faqs[index].answer,
                            initiallyExpanded: index == 0,
                          );
                        },
                      ),
                      const SizedBox(height: 32),
                      Divider(
                        height: 1,
                        thickness: 1,
                        color: palette.primary800,
                      ),
                      const SizedBox(height: 32),
                      Text(
                        'Non hai trovato quello che cercavi?',
                        style: appTextStyles.paragraphS,
                      ),
                      const SizedBox(height: 32),
                      SizedBox(
                        width: double.infinity,
                        child: CustomTextButton(
                          title: "Contattaci",
                          color: palette.primary800,
                          textStyle: appTextStyles.headingM.copyWith(
                            color: palette.grey0,
                          ),
                          verticalPadding: 4,
                          onPressed: () {},
                          alignment: MainAxisAlignment.center,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
