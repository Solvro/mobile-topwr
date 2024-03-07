import 'dart:async';

import 'package:graphql/client.dart';
import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'ttl_manager.g.dart';

@riverpod
Future<SharedPreferences> _prefs(_PrefsRef ref) {
  return SharedPreferences.getInstance();
}

@riverpod
class TTLManager extends _$TTLManager {
  @override
  Future<FetchPolicy> build(String key) async {
    if (await isCacheUpToDate) {
      _scheduleTTLInvalidation(await timeLeft);
      return FetchPolicy.cacheFirst;
    }
    return FetchPolicy.cacheAndNetwork;
  }

  final ttl = const Duration(minutes: 1);

  Future<Duration> get timeAgo async {
    final stamp = await getTimestamp ?? DateTime(0);
    return DateTime.timestamp().difference(stamp);
  }

  Future<Duration> get timeLeft async {
    final timeAgo = await this.timeAgo;
    return timeAgo - ttl;
  }

  Future<bool> get isCacheUpToDate async {
    final timeAgo = await this.timeAgo;
    return timeAgo < ttl;
  }

  static const _prefix = "TTL_CACHE_TIMESTAMP_PREFX_";
  String get _storeKey => "$_prefix$key";

  Future<DateTime?> get getTimestamp async {
    final prefs = await ref.read(_prefsProvider.future);
    return DateTime.tryParse(prefs.getString(_storeKey) ?? "");
  }

  Future<bool> recordTimestamp<T>(QueryResult<T> response) async {
    final prefs = await ref.read(_prefsProvider.future);
    final stamp = response.timestamp.toUtc().toIso8601String();
    return prefs.setString(_storeKey, stamp);
  }

  Future<T?> saveNetworkTimestamps<T>(QueryResult<T> event) async {
    if (event.source == QueryResultSource.network) {
      await recordTimestamp(event); // record last fresh data timestamp
    }
    return event.parsedData;
  }

  void _scheduleTTLInvalidation(Duration dur) {
    final timer = Timer(dur, () {
      Logger().w("INVALIDATE");
      ref.invalidateSelf();
    });
    ref.onDispose(() {
      Logger().w("Dispose");
      timer.cancel();
    });
  }
}

// final ttlManagerProvider = Provider.family.autoDispose((ref, String key) async {
//   final prefs = await SharedPreferences.getInstance();
//   return TTLManager(prefs, key: key);
// });
