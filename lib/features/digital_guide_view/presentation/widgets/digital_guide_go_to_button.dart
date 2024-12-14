import "package:flutter/material.dart";

import "../../../../config/ui_config.dart";
import "../../../../theme/app_theme.dart";
import "../../tabs/entraces/data/models/digital_guide_entrace.dart";

class DigitalGuideGoToButton extends StatelessWidget {
  const DigitalGuideGoToButton({
    super.key,
    required this.onTap,
    required this.entrace,
  });

  final VoidCallback onTap;
  final DigitalGuideEntrace entrace;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: DigitalGuideConfig.mediumButtonPadding,
        decoration: BoxDecoration(
          borderRadius:
              BorderRadius.circular(DigitalGuideConfig.borderRadiusMedium),
          border: Border.all(
            color: DigitalGuideConfig.borderColor,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              entrace.translations.pl.name,
              style: context.textTheme.title,
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: context.colorTheme.blueAzure,
            ),
          ],
        ),
      ),
    );
  }
}
