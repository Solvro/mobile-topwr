import "package:flutter/material.dart";

import "../../../theme/app_theme.dart";
import "../../bottom_nav_bar/bottom_nav_bar_icon_icons.icons.dart";
import "branch_map_dialog.dart";

class BranchesButton extends StatelessWidget {
  const BranchesButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.small(
      heroTag: "branches_button",
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      backgroundColor: context.colorScheme.surface,
      child: Icon(BottomNavBarIcons.departments_icon, color: context.colorScheme.onTertiary),
      onPressed: () => {BranchMapDialog.show(context)},
    );
  }
}
