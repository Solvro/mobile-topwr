import "dart:async";

import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../../theme/app_theme.dart";
import "../../../analytics/data/umami.dart";
import "../../../analytics/data/umami_events.dart";
import "../../data/layer_options.dart";
import "../../data/local_layers_repository.dart";
import "labels.dart";

class MapLayerCheckbox extends ConsumerWidget {
  const MapLayerCheckbox(this.option, {super.key});
  final LayerOptions option;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final value = ref.watch(localLayersRepositoryProvider(option));

    // ignore: avoid_positional_boolean_parameters
    void onChanged(bool? value) {
      if (value != null) {
        unawaited(ref.read(localLayersRepositoryProvider(option).notifier).setMode(newValue: value));
        unawaited(ref.trackEvent(UmamiEvents.setLayerOptions, value: option.sharedPrefsKey));
      }
    }

    return CheckboxListTile(
      dense: true,
      controlAffinity: ListTileControlAffinity.leading,
      title: Text(option.localizedLabel(context), style: context.aboutUsTheme.body),
      value: value.value ?? false,
      onChanged: onChanged,
    );
  }
}
