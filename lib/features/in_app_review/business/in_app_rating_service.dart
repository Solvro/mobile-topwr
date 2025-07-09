import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:in_app_review/in_app_review.dart";
import "package:shared_preferences/shared_preferences.dart";

import "../../../config/shared_prefs.dart";
import "../../../utils/datetime_utils.dart";
import "../../../utils/shared_prefs_extensions.dart";
import "../../../utils/timestamp.dart";
import "../../app_streak/business/get_days_use_case.dart";

class InAppRatingService {
  const InAppRatingService(this.ref);

  final Ref ref;

  InAppReview get _inAppReview => InAppReview.instance;

  Future<int> _getUsageDays() async {
    return await ref.read(getUsageDaysUseCaseProvider.future);
  }

  Future<SharedPreferences> get _sharedPrefs => ref.read(sharedPreferencesSingletonProvider.future);

  Future<void> requestReviewIfNeeded() async {
    if (await _canRequestReview()) {
      await _inAppReview.requestReview();
      await _updatePreferences();
    }
  }

  Future<bool> _canRequestReview() async {
    final sharedPreferences = await _sharedPrefs;
    final lastReviewPrompt = sharedPreferences
        .getTimestamp(InAppReviewConfig.lastReviewPromptDateAsString)
        .daysLeftFromNow;
    final reviewCount = sharedPreferences.getInt(InAppReviewConfig.reviewCountKey) ?? 0;
    final usageDays = await _getUsageDays();

    if (usageDays > 2 && reviewCount < 3 && lastReviewPrompt > 7 && await _inAppReview.isAvailable()) {
      return true;
    }
    return false;
  }

  Future<void> _updatePreferences() async {
    final sharedPreferences = await _sharedPrefs;
    await sharedPreferences.saveTimestamp(InAppReviewConfig.lastReviewPromptDateAsString, Timestamp.now());
    await sharedPreferences.setInt(
      InAppReviewConfig.reviewCountKey,
      (sharedPreferences.getInt(InAppReviewConfig.reviewCountKey) ?? 0) + 1,
    );
  }

  static Future<void> requestStoreListingReview() async {
    await InAppReview.instance.openStoreListing(appStoreId: "1644647395");
  }
}
