import "package:dio/dio.dart";
import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../../api_base/gql_client_provider.dart";
import "../../../../api_base_rest/client/dio_client.dart";
import "../../../../config/env.dart";
import "../../parkings_view/api_client/iparking_commands.dart";
import "../../parkings_view/models/parking.dart";
import "../../parkings_view/pick_correct_api_service/getUseParkingApiWrapper.graphql.dart";
import "../models/chart_point.dart";
import "../models/raw_chart_data.dart";

part "chart_repository.g.dart";

@riverpod
Future<IList<ChartPoint>> chartRepository(Ref ref, Parking parking) async {
  final graphqlClient = await ref.watch(grapqlClientProvider.future);
  final parkingConfigResp = await graphqlClient.query$GetUseParkingApiWrapper();
  final useParkingApiWrapper = parkingConfigResp.parsedData?.CacheReferenceNumber?.useParkingApiWrapper ?? false;
  final restClient = ref.watch(restClientProvider);

  if (!useParkingApiWrapper) {
    final classicUrl = parkingConfigResp.parsedData?.CacheReferenceNumber?.classicParkingGetCharts;
    Response<Map<String, dynamic>> response;
    if (classicUrl == null) {
      response = await ref.postIParkingCommand<Map<String, dynamic>>(FetchChartCommand(parking.id));
    } else {
      response = await restClient.get("$classicUrl/${parking.id}");
    }

    final rawData = RawChartData.fromJson((response.data?["slots"] as Map).cast());
    return rawData.toChartPoints().toIList();
  }
  final javaUrl = parkingConfigResp.parsedData?.CacheReferenceNumber?.javaWrapperURL ?? Env.parkingApiUrl;

  final response = await restClient.get<dynamic>("$javaUrl/chart/${parking.id}");
  final rawData = RawChartData.fromJson(
    // ignore: avoid_dynamic_calls
    (response.data?["slots"] as Map).cast(),
  );
  return rawData.toChartPoints().toIList();
}
