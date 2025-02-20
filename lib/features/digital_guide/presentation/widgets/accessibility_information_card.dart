import "package:flutter/material.dart";
import "package:flutter_svg/svg.dart";

import "../../../../../config/ui_config.dart";
import "../../../../../theme/app_theme.dart";
import "../../../../widgets/my_html_widget.dart";

class AccessibilityInformationCard extends StatelessWidget {
  final Color color;
  final String icon;
  final String text;

  const AccessibilityInformationCard({
    super.key,
    required this.color,
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    final isHTML = text.contains("<span style=");
    return Container(
      constraints: const BoxConstraints(
        minHeight: DigitalGuideConfig.paddingMedium +
            DigitalGuideConfig
                .difficultiesCardIconSize, // so basically if the comment is HTML, we allow it to be much longer (makes sense e.g. in Polinka case)
        // if it's not HTML, we limit it to 2 lines, so the minHeight = height in such case
      ),
      decoration: BoxDecoration(
        borderRadius:
            BorderRadius.circular(DigitalGuideConfig.borderRadiusMedium),
        color: color,
      ),
      child: Row(
        children: [
          Padding(
            padding: DigitalGuideConfig.widePaddingMedium,
            child: Container(
              width: DigitalGuideConfig.difficultiesCardIconSize,
              height: DigitalGuideConfig.difficultiesCardIconSize,
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(DigitalGuideConfig.borderRadiusSmall),
                color: Colors.white,
              ),
              child: Center(
                child: SizedBox.square(
                  dimension: 20,
                  child: SvgPicture.asset(
                    icon,
                    height: 20,
                    width: 20,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: DigitalGuideConfig.heightTiny),
          Expanded(
            child: Padding(
              padding:
                  const EdgeInsets.only(right: DigitalGuideConfig.paddingSmall),
              child: isHTML
                  ? Padding(
                      padding:
                          const EdgeInsets.all(DigitalGuideConfig.heightSmall),
                      child: MyHtmlWidget(
                        text,
                        textStyle: context.textTheme.bodyWhite,
                      ),
                    )
                  : Text(
                      text,
                      style: context.textTheme.bodyWhite,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
