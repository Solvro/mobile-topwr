import "dart:async";

import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../utils/context_extensions.dart";
import "../../analytics/data/umami.dart";
import "../../analytics/data/umami_events.dart";
import "../../digital_guide/tabs/accessibility_dialog/presentation/red_dialog.dart";
import "../data/layer_options.dart";
import "map_layer_checkbox.dart";

class LayerOptionsDialog extends StatelessWidget {
  const LayerOptionsDialog({super.key});

  static Future<void> show(BuildContext context, WidgetRef ref) async {
    unawaited(ref.trackEvent(UmamiEvents.openLayerOptionsDialog));
    await showGeneralDialog(
      context: context,
      barrierColor: Colors.transparent,
      pageBuilder: (context, animation, secondaryAnimation) {
        return const Material(type: MaterialType.transparency, child: LayerOptionsDialog());
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Semantics(
          label: context.localize.dialog_semantics_label,
          button: false,
          child: Consumer(
            builder: (context, ref, child) => GestureDetector(
              onTap: () {
                unawaited(ref.trackEvent(UmamiEvents.closeLayerOptionsDialog));
                Navigator.of(context).pop();
              },
              child: ModalBarrier(color: Colors.black.withValues(alpha: 0.7), dismissible: false),
            ),
          ),
        ),

        Consumer(
          child: Column(children: [for (final option in topLevelLayerOptions) MapLayerCheckbox(option)]),
          builder: (context, ref, child) => RedDialog(
            title: context.localize.map_details_title,
            subtitle: null,
            child: child ?? const SizedBox.shrink(),
            onApplyButtonPressed: () {
              unawaited(ref.trackEvent(UmamiEvents.saveAccessibilityModeDialog));
            },
          ),
        ),
      ],
    );
  }
}
