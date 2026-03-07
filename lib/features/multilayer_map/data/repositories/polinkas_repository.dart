import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../../api_base_rest/cache/cache.dart";
import "../../../../api_base_rest/client/json.dart";
import "../../../../config/env.dart";
import "../model/polinka_station.dart";

part "polinkas_repository.g.dart";

@riverpod
Future<IList<PolinkaStation>> polinkasRepository(Ref ref) async {
  final apiUrl = Env.mainRestApiUrl;
  final polinkaStationsResponse = await ref
      .getAndCacheData(
        "$apiUrl/polinka_stations?photo=true",
        PolinkaStationsDataResponse.fromJson,
        extraValidityCheck: (_) => true,
        onRetry: ref.invalidateSelf,
      )
      .castAsObject;
  return polinkaStationsResponse.data.toIList();
}
