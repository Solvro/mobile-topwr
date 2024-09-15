import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../gql_client_provider.dart";
import "../../../query_adapter.dart";
import "getRemoteCacheRef.graphql.dart";

part "remote_cache_ref_number_repo.g.dart";

@riverpod
Future<int?> remoteCacheRefNumberRepo(RemoteCacheRefNumberRepoRef ref) async {
  final apiClient = await ref.watch(gqlClientProvider);
  final remoteValue = await apiClient.query$GetRemoteRefCacheNumber();
  final safeRemoteValue =
      await GqlOfflineException.graphqlTryCatch(remoteValue, null);
  return safeRemoteValue.parsedData?.CacheReferenceNumber?.referenceNumber;
}
