import "package:flutter/material.dart";

import "../../../../config/ui_config.dart";

class AccessibilityButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: DigitalGuideConfig.symmetricalPaddingMedium,
      child: OutlinedButton(
        onPressed: () {},
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              DigitalGuideConfig.borderRadiusMedium,
            ),
          ),
        ),
        child: const Icon(
          Icons.accessible,
          color: Colors.black,
        ),
      ),
    );
  }
}
