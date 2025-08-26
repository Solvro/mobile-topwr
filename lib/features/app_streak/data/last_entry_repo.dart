import "dart:async";

import "package:flutter/foundation.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../config/shared_prefs.dart";
import "../../../utils/timestamp.dart";
import "timstamp_repo_mixin.dart";

part "last_entry_repo.g.dart";

@riverpod
class LastEntryRepository extends _$LastEntryRepository with TimestampRepository {
  @override
  @protected
  final storeKey = StreakRepositoriesConfig.lastEntryKey;

  @override
  Future<Timestamp> build() {
    return getStamp();
  }
}
