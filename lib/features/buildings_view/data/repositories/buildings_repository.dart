import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../../api_base_rest/client/json.dart";
import "../../../../api_base_rest/translations/translate.dart";
import "../../../../config/env.dart";
import "../../presentation/views/redirect_views.dart";
import "../model/building.dart";
import "../utils/utils.dart";

part "buildings_repository.g.dart";

@riverpod
Future<IList<Building>> buildingsRepository(Ref ref) async {
  final apiUrl = Env.mainRestApiUrl;
  final buildingsResponse = await ref
      .getAndCacheDataWithTranslation(
        "$apiUrl/buildings?cover=true",
        BuildingDataResponse.fromJson,
        extraValidityCheck: (_) => true,
        localizedOfflineMessage: BuildingsView.localizedOfflineMessage,
        onRetry: ref.invalidateSelf,
      )
      .castAsObject;
  return buildingsResponse.data.toIList().sortByCodeOrder();
}
