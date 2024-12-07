import "package:flutter/material.dart";

import "../../../../../config/ui_config.dart";

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
          side: BorderSide(
            color: Colors.black.withOpacity(0.7),
            width: 0.8,
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
