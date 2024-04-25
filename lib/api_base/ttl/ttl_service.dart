import 'dart:async';

import 'package:graphql/client.dart';
import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'local_timestamp_repository.dart';
import 'ttl_config.dart';

part 'ttl_service.g.dart';

@riverpod
class TtlService extends _$TtlService {
  @override
  Future<FetchPolicy> build(TtlKey key) async {
    ///  returns FetchPolicy that loads from cache or fetch from network
    final timestamp = await (await repository).getTimestamp();

    if (await timestamp.isCacheUpToDate) {
      _scheduleTTLInvalidation(await timestamp.timeLeft);
      return FetchPolicy.cacheFirst; // loads only from cache unless it's empty
    }

    return FetchPolicy.cacheAndNetwork; // force re-fetch
  }

  Future<LocalTimestampRepo> get repository async =>
      ref.watch(localTimestampRepoProvider.call(key).future);

  Future<T?> interceptAndSaveTimestamps<T>(QueryResult<T> event) async {
    if (event.source == QueryResultSource.network) {
      final repo = await repository;
      await repo.saveTimestamp(event); // save locally last fresh data timestamp
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

  // void _scheduleTTLInvalidation(Duration timeLeft) {
  //   final timer = Timer(timeLeft, ref.invalidateSelf);
  //   ref.onDispose(timer.cancel);
  // }
}
