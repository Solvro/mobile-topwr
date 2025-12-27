import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../../../../api_base_rest/client/json.dart";
import "../../../../../../api_base_rest/translations/translate.dart";
import "../../../../../../config/env.dart";
import "../../../../../../config/ttl_config.dart";
import "../../../../presentation/digital_guide_view.dart";
import "../models/micronavigation_response.dart";

part "micronavigation_repository.g.dart";

@riverpod
Future<IList<MicronavigationResponse>> getMicronavigationData(Ref ref, int id) async {
  final micronavigationUrl = "${Env.digitalGuideAddonsUrl}/beaconplus/?location=$id";

  final responseData = await ref.getAndCacheDataWithTranslation(
    micronavigationUrl,
    MicronavigationResponse.fromJson,
    ttlDays: TtlDays.defaultDigitalGuide,
    localizedOfflineMessage: DigitalGuideView.localizedOfflineMessage,
    extraValidityCheck: (data) {
      return data.castAsList.isNotEmpty;
    },
    onRetry: ref.invalidateSelf,
  );

  return responseData.castAsList;
}
