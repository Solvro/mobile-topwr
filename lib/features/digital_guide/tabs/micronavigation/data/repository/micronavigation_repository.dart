import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../../../../api_base_rest/client/json.dart";
import "../../../../../../api_base_rest/translations/translate.dart";
import "../../../../../../config/env.dart";
import "../../../../presentation/digital_guide_view.dart";
import "../models/micronavigation_response.dart";

part "micronavigation_repository.g.dart";

const _ttlDays = 7;

@riverpod
Future<IList<MicronavigationResponse>> getMicronavigationData(Ref ref, int id) async {
  final micronavigationUrl = "${Env.digitalGuideAddonsUrl}/beaconplus/?location=$id";

  final responseData = await ref.getAndCacheDataWithTranslation(
    micronavigationUrl,
    _ttlDays,
    MicronavigationResponse.fromJson,
    localizedOfflineMessage: DigitalGuideView.localizedOfflineMessage,
    extraValidityCheck: (data) {
      return data.castAsList.isNotEmpty;
    },
    onRetry: ref.invalidateSelf,
  );

  return responseData.castAsList;
}
