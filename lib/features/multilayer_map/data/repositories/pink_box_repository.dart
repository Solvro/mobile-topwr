import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../../api_base_rest/cache/cache.dart";
import "../../../../api_base_rest/client/json.dart";
import "../../../../config/env.dart";
import "../../presentation/views/redirect_views.dart";
import "../model/pink_box.dart";

part "pink_box_repository.g.dart";

@riverpod
Future<IList<PinkBox>> pinkBoxesRepository(Ref ref) async {
  final apiUrl = Env.mainRestApiUrl;
  final pinkBoxesResponse = await ref
      .getAndCacheData(
        "$apiUrl/pink_boxes?photo=true&building=true",
        PinkBoxDataResponse.fromJson,
        extraValidityCheck: (_) => true,
        localizedOfflineMessage: PinkBoxesView.localizedOfflineMessage,
        onRetry: ref.invalidateSelf,
      )
      .castAsObject;
  return pinkBoxesResponse.data.toIList();
}
