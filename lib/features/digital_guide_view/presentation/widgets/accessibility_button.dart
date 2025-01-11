import "package:flutter/material.dart";

import "../../../../config/ui_config.dart";
import "../../../../theme/app_theme.dart";

class AccessibilityButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: OutlinedButton(
        onPressed: () {},
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(DigitalGuideConfig.borderRadiusMedium),
          ),
          side: BorderSide(color: context.colorTheme.greyPigeon),
          backgroundColor: context.colorTheme.greyLight,
          padding: const EdgeInsets.symmetric(horizontal: 16),
        ),
        child: Icon(
          Icons.accessibility_new,
          color: context.colorTheme.blackMirage,
        ),
      ),
    );
  }
}
