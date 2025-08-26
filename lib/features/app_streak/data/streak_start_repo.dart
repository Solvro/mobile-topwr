import "dart:async";

import "package:flutter/foundation.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../config/shared_prefs.dart";
import "../../../utils/timestamp.dart";
import "timstamp_repo_mixin.dart";

part "streak_start_repo.g.dart";

@riverpod
class StreakStartRepository extends _$StreakStartRepository with TimestampRepository {
  @override
  @protected
  final storeKey = StreakRepositoriesConfig.streakStartKey;

  @override
  Future<Timestamp> build() {
    return getStamp();
  }
}
