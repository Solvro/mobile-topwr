import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../../api_base_rest/cache/cache.dart";
import "../../../../api_base_rest/client/json.dart";
import "../../../../config/env.dart";
import "../../presentation/views/redirect_views.dart";
import "../model/bicycle_shower.dart";

part "bicycle_showers_repository.g.dart";

@riverpod
Future<IList<BicycleShower>> bicycleShowersRepository(Ref ref) async {
  final apiUrl = Env.mainRestApiUrl;
  final bicycleShowersResponse = await ref
      .getAndCacheData(
        "$apiUrl/bicycle_showers?photo=true&building=true",
        BicycleShowerDataResponse.fromJson,
        extraValidityCheck: (_) => true,
        localizedOfflineMessage: ShowersView.localizedOfflineMessage,
        onRetry: ref.invalidateSelf,
      )
      .castAsObject;
  return bicycleShowersResponse.data.toIList();
}
