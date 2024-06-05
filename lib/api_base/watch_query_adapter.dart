import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql/client.dart';

import 'gql_client_provider.dart';
import '../config/ttl_config.dart';
import 'ttl/ttl_service.dart';

class GqlOfflineException implements Exception {
  const GqlOfflineException(this.ttlKey);
  final TtlKey ttlKey;
}

extension _WatchQueryStreamAdapter<T> on Ref {
  void handleErrors(QueryResult<T> event, TtlKey ttlKey) {
    if (!event.hasException) return;

    if (event.exception?.linkException != null) {
      throw GqlOfflineException(ttlKey);
    }

    throw Exception(
      event.exception,
    ); //rethrow GraphQL Errors as not silent ones
  }

  Stream<QueryResult<T>> watchQueryStreamAdapter(
    GraphQLClient client,
    WatchQueryOptions<T> options,
    TtlKey ttlKey,
  ) {
    final observableQuery = client.watchQuery(options);
    onDispose(observableQuery.close);
    return observableQuery.stream.map((event) {
      handleErrors(event, ttlKey);
      return event;
    }).where(
      (event) => event.isNotLoading,
    );
  }
}

extension TTLWatchQueryAdapter on AutoDisposeStreamProviderRef {
  Stream<T?> watchQueryWithCache<T>(
      WatchQueryOptions<T> watchQueryOptions, TtlKey ttlKey) async* {
    final apiClient = await watch(gqlClientProvider);
    final ttlService = ttlServiceProvider.call(ttlKey);
    final ttlFetchPolicy = await watch(ttlService.future);

    final newOptions = watchQueryOptions.copyWithFetchPolicy(ttlFetchPolicy);

    yield* watchQueryStreamAdapter(
      apiClient,
      newOptions,
      ttlKey,
    )
        .asyncMap(read(ttlService.notifier).interceptAndSaveTimestamps)
        .map((event) => event.parsedData);
  }
}
