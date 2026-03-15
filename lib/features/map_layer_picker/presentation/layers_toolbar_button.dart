import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../theme/app_theme.dart";
import "../../../utils/context_extensions.dart";
import "layer_options_dialog.dart";

class LayersButton extends ConsumerWidget {
  const LayersButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Transform.scale(
      scale: context.textScaler.clamp(minScaleFactor: 0.9, maxScaleFactor: 1.5).scale(1),
      child: FloatingActionButton.small(
        heroTag: "layers_button",
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        backgroundColor: context.colorScheme.surface,
        child: Icon(Icons.map, color: context.colorScheme.onTertiary),
        onPressed: () => LayerOptionsDialog.show(context, ref),
      ),
    );
  }
}
