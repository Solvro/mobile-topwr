import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../../../../../api_base_rest/client/dio_client.dart";
import "../../../../../../../config/env.dart";
import "../../../../data/models/digital_guide_response.dart";
import "../models/digital_guide_entrace.dart";

part "entraces_repository.g.dart";

@riverpod
Future<IList<DigitalGuideEntrace>> entrancesRepository(
  Ref ref,
  DigitalGuideResponse building,
) async {
  final digitalGuideEntranceUrl =
      "${Env.digitalGuideUrl}/entrances/?building=${building.id}";
  final dio = ref.read(restClientProvider);
  dio.options.headers["Authorization"] =
      "Token ${Env.digitalGuideAuthorizationToken}";
  final response = await dio.get<List<dynamic>>(digitalGuideEntranceUrl);
  final entrances = response.data
      ?.map((json) => DigitalGuideEntrace.fromJson(json))
      .toIList();
  return entrances ?? const IList.empty();
}
