import "dart:async";

import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../../../config/shared_prefs.dart";

import "./layer_options.dart";

part "local_layers_repository.g.dart";

@riverpod
class LocalLayersRepository extends _$LocalLayersRepository {
  @override
  Future<bool> build(LayerOptions layerOption) async {
    final prefs = await ref.watch(sharedPreferencesSingletonProvider.future);
    return prefs.getBool(layerOption.sharedPrefsKey) ?? true;
  }

  Future<void> setMode({required bool newValue}) async {
    state = AsyncValue.data(newValue);
    final prefs = await ref.watch(sharedPreferencesSingletonProvider.future);
    await prefs.setBool(layerOption.sharedPrefsKey, newValue);
  }
}
