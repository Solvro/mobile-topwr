import "package:riverpod_annotation/riverpod_annotation.dart";
import "package:shared_preferences/shared_preferences.dart";

part "shared_prefs.g.dart";

@Riverpod(keepAlive: true)
Future<SharedPreferences> sharedPreferencesSingleton(
  SharedPreferencesSingletonRef ref,
) {
  return SharedPreferences.getInstance();
}

abstract class StreakRepositoriesConfig {
  static const lastEntryKey = "__app_streak_counter__last_entry_stamp";
  static const streakStartKey = "__app_streak_counter__streak_start_stamp";
}
