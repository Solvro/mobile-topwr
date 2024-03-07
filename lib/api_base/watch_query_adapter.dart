import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql/client.dart';

import 'gql_client_provider.dart';
import 'ttl_manager.dart';

extension _WatchQueryStreamAdapter on Ref {
  Stream<QueryResult<T>> streamAdapter<T>(
      GraphQLClient client, WatchQueryOptions<T> options) {
    final observableQuery = client.watchQuery(options);
    onDispose(observableQuery.close);
    return observableQuery.stream.where(
      (event) {
        if (event.hasException) {
          throw Exception(event.exception); //rethrow GraphQL Errors
        }
        return event.isNotLoading;
      },
    );
  }
}

extension TTLAutodisposeWatchQueryAdapter on AutoDisposeStreamProviderRef {
  Stream<T?> watchQueryWithCache<T>(
      WatchQueryOptions<T> watchQueryOptions, String key) async* {
    final apiClient = await watch(gqlClientProvider);
    final ttlProv = tTLManagerProvider.call(key);
    final ttlFetchPolicy = await watch(ttlProv.future);

    final options = watchQueryOptions.copyWithFetchPolicy(ttlFetchPolicy);

    yield* streamAdapter(apiClient, options)
        .asyncMap(read(ttlProv.notifier).saveNetworkTimestamps);
  }
}
