import "package:flutter/material.dart";

import "../../../theme/app_theme.dart";
import "../../../utils/context_extensions.dart";
import "../../bottom_nav_bar/bottom_nav_bar_icon_icons.icons.dart";
import "branch_map_dialog.dart";

class BranchesButton extends StatelessWidget {
  const BranchesButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: context.textScaler.clamp(minScaleFactor: 0.9, maxScaleFactor: 1.5).scale(1),
      child: FloatingActionButton.small(
        heroTag: "branches_button",
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        backgroundColor: context.colorScheme.surface,
        child: Icon(BottomNavBarIcons.departments_icon, color: context.colorScheme.onTertiary),
        onPressed: () => {BranchMapDialog.show(context)},
      ),
    );
  }
}
