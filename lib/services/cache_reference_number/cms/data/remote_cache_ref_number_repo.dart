import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../../features/remote_config/data/repository/remote_config_repository.dart";

part "remote_cache_ref_number_repo.g.dart";

@riverpod
Future<int?> remoteCacheRefNumberRepo(Ref ref) async {
  final remoteConfig = await ref.watch(remoteConfigRepositoryProvider.future);
  return remoteConfig.cmsReferenceNumber;
}
