import "dart:async";

import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:fluttertoast/fluttertoast.dart";

import "../../../../theme/app_theme.dart";
import "../../../../theme/colors.dart";
import "../../../../utils/context_extensions.dart";
import "../../../analytics/data/umami.dart";
import "../../../analytics/data/umami_events.dart";
import "../../business/layers_enabled_service.dart";
import "../../data/layer_options.dart";
import "../../data/local_layers_repository.dart";
import "labels.dart";

class MapLayerCheckbox extends ConsumerWidget {
  const MapLayerCheckbox(this.option, {super.key});
  final LayerOptions option;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final value = ref.watch(localLayersRepositoryProvider(option)).value ?? false;
    final areOnlyOneEnabled = ref.watch(areOnlyOneLayerEnabledProvider).value ?? true;
    final checkboxDisabled = value && areOnlyOneEnabled;

    // ignore: avoid_positional_boolean_parameters
    void onChanged(bool? value) {
      if (value != null) {
        unawaited(ref.read(localLayersRepositoryProvider(option).notifier).setMode(newValue: value));
        unawaited(ref.trackEvent(UmamiEvents.setLayerOptions, value: option.sharedPrefsKey));
      }
    }

    return GestureDetector(
      onTap: checkboxDisabled
          ? () async {
              await Fluttertoast.showToast(
                msg: context.localize.map_layer_minimum_required,
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                backgroundColor: ColorsConsts.greyLight.withAlpha(200),
                textColor: ColorsConsts.blackMirage,
              );
            }
          : null,
      child: CheckboxListTile(
        dense: true,
        controlAffinity: ListTileControlAffinity.leading,
        title: Text(option.localizedLabel(context), style: context.aboutUsTheme.body),
        value: value,
        onChanged: onChanged,
        enabled: !checkboxDisabled,
      ),
    );
  }
}
