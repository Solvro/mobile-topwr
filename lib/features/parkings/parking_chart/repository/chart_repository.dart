import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../../api_base_rest/client/dio_client.dart";
import "../../../../config/env.dart";
import "../../parkings_view/models/parking.dart";
import "../models/chart_point.dart";
import "../models/raw_chart_data.dart";

part "chart_repository.g.dart";

@riverpod
Future<IList<ChartPoint>> chartRepository(Ref ref, Parking parking) async {
  final restClient = ref.watch(restClientProvider);
  final classicUrl = Env.parkingApiUrl;
  final response = await restClient.get<Map<String, dynamic>>("$classicUrl/${parking.id}");
  final rawData = RawChartData.fromJson((response.data?["slots"] as Map).cast());
  return rawData.toChartPoints().toIList();
}
