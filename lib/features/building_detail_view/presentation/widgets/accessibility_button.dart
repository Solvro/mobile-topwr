import "package:flutter/material.dart";

import "../../../../config/ui_config.dart";

class AccessibilityButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: BuildingDetailConfig.symmetricalPaddingMedium,
      child: OutlinedButton(
        onPressed: () {},
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              BuildingDetailConfig.borderRadiusMedium,
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
