import "dart:async";

import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../../../utils/context_extensions.dart";
import "../../../../analytics/data/umami.dart";
import "../../../../analytics/data/umami_events.dart";
import "checkboxes_list.dart";
import "red_dialog.dart";

class AccessibilityDialog extends StatelessWidget {
  const AccessibilityDialog({super.key});

  static Future<void> show(BuildContext context, WidgetRef ref) async {
    unawaited(ref.trackEvent(UmamiEvents.openAccessibilityModeDialog));
    await showGeneralDialog(
      context: context,
      barrierColor: Colors.transparent,
      pageBuilder: (context, animation, secondaryAnimation) {
        return const Material(type: MaterialType.transparency, child: AccessibilityDialog());
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
                unawaited(ref.trackEvent(UmamiEvents.closeAccessibilityModeDialog));
                Navigator.of(context).pop();
              },
              child: ModalBarrier(color: Colors.black.withValues(alpha: 0.7), dismissible: false),
            ),
          ),
        ),

        Consumer(
          child: const CheckboxesList(),
          builder: (context, ref, child) => RedDialog(
            title: context.localize.accessibility_profiles,
            subtitle: context.localize.you_can_adjust,
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
