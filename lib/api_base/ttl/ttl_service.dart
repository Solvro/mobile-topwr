import "dart:async";

import "package:graphql/client.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../config/ttl_config.dart";
import "local_timestamp_repository.dart";

part "ttl_service.g.dart";

@riverpod
class TtlService extends _$TtlService {
  @override
  Future<FetchPolicy> build(TtlKey key) async {
    final timestamp = (await repository).getTimestamp();
    if (await timestamp.isCacheUpToDate) {
      _scheduleTTLInvalidation(await timestamp.timeLeft);
      return FetchPolicy.cacheFirst; // loads only from cache unless it's empty
    }
    return FetchPolicy.networkOnly; // force re-fetch
  }

  Future<LocalTimestampRepository> get repository async =>
      ref.watch(localTimestampRepositoryProvider.call(key).future);

  Future<QueryResult<T>> interceptAndSaveTimestamps<T>(
    QueryResult<T> event,
  ) async {
    if (event.source == QueryResultSource.network) {
      final repo = await repository;
      await repo.saveTimestamp(event);
    }
    return event;
  }

  void _scheduleTTLInvalidation(Duration timeLeft) {
    final timer = Timer(timeLeft, ref.invalidateSelf);
    ref.onDispose(timer.cancel);
  }
}
