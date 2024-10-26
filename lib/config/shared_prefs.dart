import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";
import "package:shared_preferences/shared_preferences.dart";

part "shared_prefs.g.dart";

@Riverpod(keepAlive: true)
Future<SharedPreferences> sharedPreferencesSingleton(
  Ref ref,
) {
  return SharedPreferences.getInstance();
}

abstract class StreakRepositoriesConfig {
  static const lastEntryKey = "__app_streak_counter__last_entry_stamp";
  static const streakStartKey = "__app_streak_counter__streak_start_stamp";
}

abstract class InAppReviewConfig {
  static const reviewCountKey = "__app_in_app_review__review_count";
  static const lastReviewPromptDateInMillis =
      "__app_in_app_review__last_review_prompt";
}
