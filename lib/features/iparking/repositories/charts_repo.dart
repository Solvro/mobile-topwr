import 'package:collection/collection.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/chart_data_model.dart';
import '../api_client/iparking_commands.dart';
import 'parkings_repo.dart';

part "charts_repo.g.dart";

@riverpod
class ChartsRepo extends _$ChartsRepo {
  Future<ChartData> _fetchChart(int index) async {
    final response = await ref.postIParkingCommand(
      FetchChartCommand(index),
    );
    return ChartData.fromJson(response.data["slots"] as Map<String, dynamic>);
  }

  @override
  FutureOr<Iterable<ChartData>?> build() async {
    final parkings = await ref.watch(parkingsRepoProvider.future) ?? [];
    return Future.wait(
      parkings.mapIndexed((index, e) => _fetchChart(index)).toList(),
    );
  }
}
