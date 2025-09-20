import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../theme/app_theme.dart";
import "picker/layer_options_dialog.dart";

class LayersButton extends ConsumerWidget {
  const LayersButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FloatingActionButton.small(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      backgroundColor: context.colorTheme.whiteSoap,
      child: Icon(Icons.map, color: context.colorTheme.blackMirage),
      onPressed: () => LayerOptionsDialog.show(context, ref),
    );
  }
}
