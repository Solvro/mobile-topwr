import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../config/shared_prefs.dart";
import "../../../services/haptics/app_haptics.dart";

part "haptic_feedback_repository.g.dart";

@riverpod
class HapticFeedbackRepository extends _$HapticFeedbackRepository {
  @override
  bool build() {
    final prefs = ref.watch(sharedPreferencesSingletonProvider);
    final isEnabled = switch (prefs) {
      AsyncError() => true,
      AsyncValue(:final value) => value?.getBool(HapticFeedbackConfig.enabledKey) ?? true,
    };
    AppHaptics.setEnabled(isEnabled: isEnabled);
    return isEnabled;
  }

  Future<void> setEnabled({required bool isEnabled}) async {
    state = isEnabled;
    AppHaptics.setEnabled(isEnabled: isEnabled);
    final prefs = await ref.read(sharedPreferencesSingletonProvider.future);
    await prefs.setBool(HapticFeedbackConfig.enabledKey, isEnabled);
  }
}
