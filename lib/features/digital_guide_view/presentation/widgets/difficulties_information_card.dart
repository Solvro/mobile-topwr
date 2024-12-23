import "package:flutter/material.dart";
import "package:flutter_svg/svg.dart";

import "../../../../../config/ui_config.dart";
import "../../../../../theme/app_theme.dart";

class DifficultiesInformationCard extends StatelessWidget {
  final Color color;
  final String icon;
  final String text;
  

  const DifficultiesInformationCard({
    super.key,
    required this.color,
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: DigitalGuideConfig.symetricalPaddingSmall,
      child: Container(
        width: double.infinity,
        height: DigitalGuideConfig.paddingSmall * 2 + DigitalGuideConfig.difficultiesCardIconSize,
        decoration: BoxDecoration(
          borderRadius:
              BorderRadius.circular(DigitalGuideConfig.borderRadiusMedium),
          color: color,
        ),
        child: Row(
          children: [
            Padding(
              padding: DigitalGuideConfig.symetricalPaddingSmall,
              child: Container(
                width: DigitalGuideConfig.difficultiesCardIconSize,
                height: DigitalGuideConfig.difficultiesCardIconSize,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                      DigitalGuideConfig.borderRadiusSmall,),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: DigitalGuideConfig.symetricalPaddingSmall,
                  child: SvgPicture.asset(icon),
                ),
              ),
            ),
            const SizedBox(width: DigitalGuideConfig.paddingSmall),
            Expanded(
              child: Text(
                text,
                style: context.textTheme.bodyWhite,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
