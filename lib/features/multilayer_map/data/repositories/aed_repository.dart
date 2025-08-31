import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../../api_base_rest/cache/cache.dart";
import "../../../../api_base_rest/client/json.dart";
import "../../../../config/env.dart";
import "../../presentation/views/redirect_views.dart";
import "../model/aed.dart";

part "aed_repository.g.dart";

@riverpod
Future<IList<Aed>> aedsRepository(Ref ref) async {
  final apiUrl = Env.mainRestApiUrl;
  final librariesResponse = await ref
      .getAndCacheData(
        "$apiUrl/aeds?photo=true&building=true",
        AedDataResponse.fromJson,
        extraValidityCheck: (_) => true,
        localizedOfflineMessage: AedsView.localizedOfflineMessage,
        onRetry: ref.invalidateSelf,
      )
      .castAsObject;
  return librariesResponse.data.toIList();
}
