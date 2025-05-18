import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../../config/ttl_config.dart";
import "../../../api_base_rest/cache/cache.dart";
import "../../../api_base_rest/client/json.dart";
import "../../../config/env.dart";
import "../buildings_view.dart";
import "../model/building_data.dart";
import "../model/building_model.dart";
import "../utils/utils.dart";

part "buildings_repository.g.dart";

@riverpod
Future<IList<BuildingModel>> buildingsRepository(Ref ref) async {
  final apiUrl = Env.mainRestApiUrl;
  final buildingsResponse =
      await ref
          .getAndCacheData(
            "$apiUrl/buildings?cover=true",
            TtlStrategy.get(TtlKey.buildingsRepository).inDays,
            BuildingDataResponse.fromJson,
            extraValidityCheck: (_) => true,
            localizedOfflineMessage: BuildingsView.localizedOfflineMessage,
            onRetry: ref.invalidateSelf,
          )
          .castAsObject;
  return buildingsResponse.data.map(BuildingModel.from).toIList().sortByCodeOrder();
}
