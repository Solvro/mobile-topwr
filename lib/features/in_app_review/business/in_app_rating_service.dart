import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:in_app_review/in_app_review.dart";
import "package:shared_preferences/shared_preferences.dart";

import "../../../config/shared_prefs.dart";
import "../../../utils/datetime_utils.dart";
import "../../app_streak/business/get_days_use_case.dart";


class InAppRatingService {
  const InAppRatingService(this.ref);

  final Ref ref;

  InAppReview get _inAppReview => InAppReview.instance;

  Future<int> _getUsageDays() async {
    return await ref.read(getUsageDaysUseCaseProvider.future);
  }

  SharedPreferences get _sharedPrefs =>
      ref
          .read(sharedPreferencesSingletonProvider)
          .requireValue;

  Future<void> requestReviewIfNeeded() async {
    if (await _canRequestReview()) {
      await _inAppReview.requestReview();
      await _updatePreferences();
    }
  }

  Future<bool> _canRequestReview() async {
    final lastReviewPrompt = _sharedPrefs.getInt(
        InAppReviewConfig.lastReviewPromptDateInMillis,);
    final reviewCount = _sharedPrefs.getInt(InAppReviewConfig.reviewCountKey) ??
        0;
    final usageDays = await _getUsageDays();

    if (usageDays > 2 && reviewCount < 3 && await _inAppReview.isAvailable()) {
      final DateTime lastReviewPromptDate = lastReviewPrompt != null ? DateTime
          .fromMillisecondsSinceEpoch(lastReviewPrompt) : DateTime.now();
      if (DateTime
          .now()
          .difference(lastReviewPromptDate)
          .inDays > 7) {
        return true;
      }
    }
    return false;
  }

  Future<void> _updatePreferences() async {
    await _sharedPrefs.setInt(InAppReviewConfig.lastReviewPromptDateInMillis,
        now.millisecondsSinceEpoch,);
    await _sharedPrefs.setInt(InAppReviewConfig.reviewCountKey,
      (_sharedPrefs.getInt(InAppReviewConfig.reviewCountKey) ?? 0) + 1,);
  }
}
