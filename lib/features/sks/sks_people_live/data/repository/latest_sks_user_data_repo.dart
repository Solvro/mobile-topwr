import "dart:async";

import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../../../api_base_rest/client/dio_client.dart";
import "../../../../../config/env.dart";
import "../../../../../features/remote_config/data/repository/remote_config_repository.dart";
import "../../../../../utils/ref_extensions.dart";
import "../models/sks_user_data.dart";
import "../sks_people_live_config.dart";

part "latest_sks_user_data_repo.g.dart";

@riverpod
Future<SksUserData> getLatestSksUserData(Ref ref) async {
  final dio = ref.watch(restClientProvider);
  final remoteConfig = await ref.watch(remoteConfigRepositoryProvider.future);
  final sksUrl = remoteConfig.sksMicroserviceUrl ?? Env.sksUrl;
  final latestDataUrl = "$sksUrl/api/v1/sks-users/current/";
  final response = await dio.get<dynamic>(latestDataUrl);
  final sksData = SksUserData.fromJson((response.data as Map).cast());

  final currentTime = DateTime.now();
  final sksRefreshInterval = sksData.isResultRecent
      ? sksData.nextUpdateTimestamp.difference(currentTime)
      : SksPeopleRepositoryConfig.defaultSksRefreshTime;

  ref.setRefresh(sksRefreshInterval);

  return sksData;
}
