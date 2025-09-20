import "package:flutter/material.dart";

import "../../../theme/app_theme.dart";

class LayersButton extends StatelessWidget {
  const LayersButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.small(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      backgroundColor: context.colorTheme.whiteSoap,
      child: Icon(Icons.map, color: context.colorTheme.blackMirage),
      onPressed: () => {},
    );
  }
}
