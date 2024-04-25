import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql/client.dart';

import 'gql_client_provider.dart';
import 'ttl/ttl_config.dart';
import 'ttl/ttl_service.dart';

extension _WatchQueryStreamAdapter on Ref {
  Stream<QueryResult<T>> watchQueryStreamAdapter<T>(
    GraphQLClient client,
    WatchQueryOptions<T> options,
  ) {
    final observableQuery = client.watchQuery(options);
    onDispose(observableQuery.close);
    return observableQuery.stream.map((event) {
      if (event.hasException) {
        throw Exception(
            event.exception); //rethrow GraphQL Errors as not silent ones
      }
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
    ).asyncMap(read(ttlService.notifier).interceptAndSaveTimestamps);
  }
}
