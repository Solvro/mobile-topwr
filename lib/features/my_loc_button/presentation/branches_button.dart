import "package:flutter/material.dart";

import "../../../theme/app_theme.dart";
import "../../bottom_nav_bar/bottom_nav_bar_icon_icons.icons.dart";

class BranchesButton extends StatelessWidget {
  const BranchesButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.small(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      backgroundColor: context.colorTheme.whiteSoap,
      child: Icon(BottomNavBarIcons.departments_icon, color: context.colorTheme.blackMirage),
      onPressed: () => {},
    );
  }
}
