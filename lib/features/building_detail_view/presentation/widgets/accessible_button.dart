import "package:flutter/material.dart";

import "../../../../config/ui_config.dart";

class AccessibleButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: BuildingDetailConfig.accessibleButtonPadding,
      child: OutlinedButton(
        onPressed: () {},
        style: OutlinedButton.styleFrom(
          //side: const BorderSide(),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
                BuildingDetailConfig.accessibleButtonBorderRadius),
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
