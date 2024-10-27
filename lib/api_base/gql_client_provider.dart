import "package:flutter/foundation.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:graphql/client.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";
import "../config/env.dart";

part "gql_client_provider.g.dart";

@riverpod
Future<GraphQLCache> _hiveCacheBox(Ref ref) async {
  if (kIsWeb) return GraphQLCache(); // Normal in memory cache
  final box = await HiveStore.open(boxName: ApiBaseConfig.hiveCacheBoxName);
  return GraphQLCache(store: box); // Local persistent on-disk cache with Hive}
}

@riverpod
Future<GraphQLClient> grapqlClient(Ref ref) async {
  final hiveCache = await ref.watch(_hiveCacheBoxProvider.future);
  return GraphQLClient(
    cache: hiveCache,
    link: HttpLink(Env.apiUrl),
    defaultPolicies: DefaultPolicies(
      query: Policies(
        fetch: FetchPolicy.networkOnly,
      ),
      watchQuery: Policies(
        fetch: FetchPolicy.cacheAndNetwork,
      ),
    ),
  );
}

extension GqlClientProviderX<T> on QueryOptions<T> {
  QueryOptions<T> copyWithFetchPolicy(FetchPolicy policy) => copyWithPolicies(
        Policies(fetch: policy),
      );
}
