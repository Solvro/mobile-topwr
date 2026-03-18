import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../../api_base_rest/client/dio_client.dart";
import "../../../../config/env.dart";
import "../../../../features/remote_config/data/repository/remote_config_repository.dart";
import "../../parkings_view/models/parking.dart";
import "../models/chart_point.dart";
import "../models/raw_chart_data.dart";

part "chart_repository.g.dart";

@riverpod
Future<IList<ChartPoint>> chartRepository(Ref ref, Parking parking) async {
  final restClient = ref.watch(restClientProvider);
  final remoteConfig = await ref.watch(remoteConfigRepositoryProvider.future);
  final parkingBaseUrl = remoteConfig.parkingMicroserviceUrl ?? Env.parkingApiUrl;
  final parkingApiUrl = "$parkingBaseUrl/api/v1/parkings";
  final response = await restClient.get<Map<String, dynamic>>("$parkingApiUrl/${parking.id}");
  final rawData = RawChartData.fromJson((response.data?["slots"] as Map).cast());
  return rawData.toChartPoints().toIList();
}
