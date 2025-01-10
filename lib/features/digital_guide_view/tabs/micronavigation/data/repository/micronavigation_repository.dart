import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:logger/logger.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../../../../api_base_rest/client/dio_client.dart";
import "../models/micronavigation_response.dart";

part "micronavigation_repository.g.dart";

@riverpod
Future<IList<MicronavigationResponse>> getMicronavigationData(
  Ref ref,
  int id,
) async {
  const micronavigationUrlEndpoint =
      "https://przewodnik.pwr.edu.pl//api2"; // maybe we should add this to .env, but since its unprotected I add this here for now

  final micronavigationUrl =
      "$micronavigationUrlEndpoint/beaconplus/?location=$id";
  final dio = ref.read(restClientProvider);
  final response = await dio.get(micronavigationUrl);
  Logger().i("URL: $micronavigationUrl");
  final List<dynamic> responseData = response.data as List<dynamic>;
  Logger().i("response data: $responseData");
  return responseData
      .map(
        (item) =>
            MicronavigationResponse.fromJson(item as Map<String, dynamic>),
      )
      .toIList();
}
