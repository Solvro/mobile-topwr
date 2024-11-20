import "dart:async";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";
import "../../../../shared_api_clients/sks_api_client.dart";
import "../models/sks_user_data.dart";

part "latest_sks_user_data_repo.g.dart";

extension RefIntervalRefreshX on Ref {
  void setRefresh(Duration interval) {
    final timer = Timer.periodic(
      interval,
      (t) => invalidateSelf(),
    );
    onDispose(timer.cancel);
  }
}

@riverpod
Future<SksUserData> getLatestSksUserData(Ref ref) async {
  final dio = ref.read(sksClientProvider);
  const latestDataEndpoint = "/sks-users/current/";
  final response = await dio.get(latestDataEndpoint);
  final sksData = SksUserData.fromJson(response.data as Map<String, dynamic>);

  final currentTime = DateTime.now();
  final sksRefreshInterval = sksData.isResultRecent
      ? sksData.nextUpdateTimestamp.difference(currentTime)
      : const Duration(minutes: 1);

  ref.setRefresh(sksRefreshInterval);

  return sksData;
}
