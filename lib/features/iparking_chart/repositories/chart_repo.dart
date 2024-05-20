import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../iparking/api_client/iparking_commands.dart';
import '../models/chart_data_model.dart';
import '../../iparking/models/parking_model.dart';

part "chart_repo.g.dart";

@riverpod
Future<RawChartData> chartRepo(
    ChartRepoRef ref, ParkingPlace parkingPlace) async {
  final response = await ref.postIParkingCommand(
    FetchChartCommand(parkingPlace.id),
  );
  return RawChartData.fromJson(response.data["slots"] as Map<String, dynamic>);
}
