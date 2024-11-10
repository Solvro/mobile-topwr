import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../api_client/sks_client.dart";
import "../models/sks_user_data.dart";

part "latest_sks_user_data_repo.g.dart";

@riverpod
Future<SksUserData> getLatestSksUserData(Ref ref) async {
  final dio = ref.read(sksClientProvider);
  final response = await dio.get(SksClientConfig.latestDataEndpoint);
  return SksUserData.fromJson(response.data as Map<String, dynamic>);
}
