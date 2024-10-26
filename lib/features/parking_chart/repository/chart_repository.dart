import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../parkings_view/api_client/iparking_commands.dart";
import "../../parkings_view/models/parking.dart";
import "../models/chart_point.dart";
import "../models/raw_chart_data.dart";

part "chart_repository.g.dart";

@riverpod
Future<IList<ChartPoint>> chartRepository(
  Ref ref,
  Parking parking,
) async {
  final response = await ref.postIParkingCommand<Map<String, dynamic>>(
    FetchChartCommand(parking.id),
  );
  final rawData = RawChartData.fromJson(
    response.data?["slots"],
  );
  return rawData.toChartPoints().toIList();
}
