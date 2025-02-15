import "dart:async";

import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../../../config/shared_prefs.dart";
import "modes.dart";

part "accessibility_mode_repository.g.dart";

@riverpod
class AccessibilityModeRepository extends _$AccessibilityModeRepository {
  @override
  Future<bool> build(ModeWithKey mode) async {
    final prefs = await ref.watch(sharedPreferencesSingletonProvider.future);
    return prefs.getBool(mode.sharedPrefsKey) ?? false;
  }

  Future<void> setMode({required bool newValue}) async {
    state = AsyncValue.data(newValue);
    final prefs = await ref.watch(sharedPreferencesSingletonProvider.future);
    await prefs.setBool(mode.sharedPrefsKey, newValue);
  }
}
