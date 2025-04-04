import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../../../api_base_rest/client/dio_client.dart";
import "../../../../../config/env.dart";
import "../models/sks_chart_data.dart";

part "sks_chart_repository.g.dart";

@riverpod
Future<IList<SksChartData>> sksChartRepository(Ref ref) async {
  final dio = ref.watch(restClientProvider);
  final latestChartDataUrl = "${Env.sksUrl}/sks-users/today/";
  final response = await dio.get<dynamic>(latestChartDataUrl);
  final data = response.data as List<dynamic>;
  final chartDataList = data.map((entry) => SksChartData.fromJson((entry as Map).cast())).toIList();

  return chartDataList;
}
