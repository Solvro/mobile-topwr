import "dart:async";

import "package:flutter/material.dart";

import "../../../services/haptics/app_haptics.dart";
import "../../../theme/app_theme.dart";
import "../../../utils/context_extensions.dart";
import "../../bottom_nav_bar/bottom_nav_bar_icon_icons.icons.dart";
import "branch_map_dialog.dart";

class BranchesButton extends StatelessWidget {
  const BranchesButton({super.key});

  @override
  Widget build(BuildContext context) {
    final label = "${context.localize.branches} ${context.localize.map}";

    return Transform.scale(
      scale: context.textScaler.clamp(minScaleFactor: 0.9, maxScaleFactor: 1.5).scale(1),
      child: FloatingActionButton.small(
        heroTag: "branches_button",
        tooltip: label,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        backgroundColor: context.colorScheme.surface,
        child: Icon(BottomNavBarIcons.departments_icon, semanticLabel: label, color: context.colorScheme.onTertiary),
        onPressed: () async {
          unawaited(AppHaptics.selectionClick());
          await BranchMapDialog.show(context);
        },
      ),
    );
  }
}
