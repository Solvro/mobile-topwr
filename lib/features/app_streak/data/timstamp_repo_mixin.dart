import "dart:async";

import "package:flutter/foundation.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../config/shared_prefs.dart";
import "../../../utils/timestamp.dart";

// Resuable mixin for creating different timestamp repositories
mixin TimestampRepository on AutoDisposeAsyncNotifier<Timestamp> {
  @protected
  String get storeKey;

  @override
  Future<Timestamp> build();

  Future<Timestamp> getStamp() async {
    final prefs = await ref.watch(sharedPreferencesSingletonProvider.future);
    final stamp = prefs.getString(storeKey);
    if (stamp == null) {
      await resetStamp();
      return Timestamp.now();
    }
    return Timestamp.tryParse(stamp);
  }

  Future<void> resetStamp() async {
    final now = Timestamp.now();
    final prefs = await ref.read(sharedPreferencesSingletonProvider.future);
    await prefs.setString(storeKey, now.serializeUTC());
  }
}
