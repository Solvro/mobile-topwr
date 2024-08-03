import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../parkings_view/api_client/iparking_commands.dart";
import "../../parkings_view/models/parking.dart";
import "../models/raw_chart_data.dart";

part "chart_repository.g.dart";

@riverpod
Future<RawChartData> chartRepository(
  ChartRepositoryRef ref,
  Parking parking,
) async {
  final response = await ref.postIParkingCommand<Map<String, dynamic>>(
    FetchChartCommand(parking.id),
  );
  return RawChartData.fromJson(
    response.data?["slots"],
  );
}
