import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../../../../../api_base_rest/client/dio_client.dart";
import "../../../../../../../config/env.dart";

import "../models/digital_guide_entrace.dart";

part "entraces_repository.g.dart";

@riverpod
Future<IList<DigitalGuideEntrace>> getDigitalGuideEntraces(
  Ref ref,
  int buildingId,
) async {
  final digitalGuideEntranceUrl =
      "${Env.digitalGuideUrl}/entrances/?building=$buildingId";
  final dio = ref.read(restClientProvider);
  dio.options.headers["Authorization"] =
      "Token ${Env.digitalGuideAuthorizationToken}";

  final response = await dio.get(digitalGuideEntranceUrl);
  final data = response.data as List<dynamic>;
  final entrances = data
      .map((json) => DigitalGuideEntrace.fromJson(json as Map<String, dynamic>))
      .toIList();

  return entrances;
}
