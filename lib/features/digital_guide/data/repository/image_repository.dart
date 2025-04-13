import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../../api_base_rest/cache/cache.dart";
import "../../../../api_base_rest/client/json.dart";
import "../../../../config/env.dart";
import "../../presentation/digital_guide_view.dart";
import "../api/digital_guide_get_and_cache.dart";

part "image_repository.g.dart";

@riverpod
Future<String?> imageRepository(Ref ref, int imageID) async {
  return ref
      .getAndCacheData(
        "${Env.digitalGuideUrl}/images/$imageID",
        DigitalGuideClient.digitalGuideTTLDays,
        (Map<String, dynamic> json) => json["image_1920w"] as String,
        onRetry: ref.invalidateSelf,
        extraValidityCheck: (_) => true,
        localizedOfflineMessage: DigitalGuideView.localizedOfflineMessage,
        authHeader: (authotization: "Token ${Env.digitalGuideAuthorizationToken}"),
      )
      .castAsObject;
}
