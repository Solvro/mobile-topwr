import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";
import "../../../../shared_api_clients/sks_api_client.dart";
import "../models/sks_user_data.dart";

part "latest_sks_user_data_repo.g.dart";

@riverpod
Future<SksUserData> getLatestSksUserData(Ref ref) async {
  final dio = ref.read(sksClientProvider);
  const latestDataEndpoint = "sks-users/current/";
  final response = await dio.get(latestDataEndpoint);
  return SksUserData.fromJson(response.data as Map<String, dynamic>);
}
