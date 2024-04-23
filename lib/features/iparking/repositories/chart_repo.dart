import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../api_client/iparking_commands.dart';
import '../models/chart_data_model.dart';
import '../models/parking_model.dart';

part "chart_repo.g.dart";

@riverpod
Future<ChartData> chartRepo(ChartRepoRef ref, ParkingPlace parkingPlace) async {
  final response = await ref.postIParkingCommand(
    FetchChartCommand(parkingPlace.lp),
  );
  return ChartData.fromJson(response.data["slots"] as Map<String, dynamic>);
}
