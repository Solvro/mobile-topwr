import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../theme/app_theme.dart";
import "layer_options_dialog.dart";

class LayersButton extends ConsumerWidget {
  const LayersButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FloatingActionButton.small(
      heroTag: "layers_button",
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      backgroundColor: context.colorScheme.surface,
      child: Icon(Icons.map, color: context.colorScheme.onTertiary),
      onPressed: () => LayerOptionsDialog.show(context, ref),
    );
  }
}
