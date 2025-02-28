import "dart:async";

import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../../../theme/app_theme.dart";
import "../business/accessibility_mode_service.dart";
import "../data/modes.dart";
import "labels.dart";

class ModeCheckbox extends ConsumerWidget {
  const ModeCheckbox(this.mode, {super.key});
  final AccessibilityMode mode;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final value = ref.watch(accessibilityModeServiceProvider(mode));

    // ignore: avoid_positional_boolean_parameters
    void onChanged(bool? value) {
      if (value != null) {
        unawaited(ref.read(accessibilityModeServiceProvider(mode).notifier).setMode(newValue: value));
      }
    }

    return CheckboxListTile(
      dense: true,
      controlAffinity: ListTileControlAffinity.leading,
      title: Text(mode.localizedLabel(context), style: context.aboutUsTheme.body),
      value: value.value ?? false,
      onChanged: onChanged,
    );
  }
}
