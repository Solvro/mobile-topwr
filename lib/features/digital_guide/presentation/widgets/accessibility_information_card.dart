import "package:flutter/material.dart";
import "package:flutter_svg/svg.dart";

import "../../../../../config/ui_config.dart";
import "../../../../../theme/app_theme.dart";

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
    return Container(
      width: double.infinity,
      height: DigitalGuideConfig.paddingMedium +
          DigitalGuideConfig.difficultiesCardIconSize,
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
              child: Text(
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
