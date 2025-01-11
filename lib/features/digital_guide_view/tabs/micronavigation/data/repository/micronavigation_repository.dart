import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../../../../api_base_rest/client/dio_client.dart";
import "../../../../../../config/env.dart";
import "../models/micronavigation_response.dart";

part "micronavigation_repository.g.dart";

@riverpod
Future<IList<MicronavigationResponse>> getMicronavigationData(
  Ref ref,
  int id,
) async {
  final micronavigationUrl =
      "${Env.digitalGuideUrlMicronavigation}/beaconplus/?location=$id";
  final dio = ref.read(restClientProvider);
  final response = await dio.get(micronavigationUrl);
  final List<dynamic> responseData = response.data as List<dynamic>;
  return responseData
      .map(
        (item) =>
            MicronavigationResponse.fromJson(item as Map<String, dynamic>),
      )
      .toIList();
}
