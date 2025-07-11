import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../../api_base_rest/cache/cache.dart";
import "../../../../api_base_rest/client/json.dart";
import "../../../../config/env.dart";
import "../../../../config/ttl_config.dart";
import "../../presentation/digital_guide_view.dart";

part "image_repository.g.dart";

@riverpod
Future<String?> imageRepository(Ref ref, int imageID) async {
  return ref
      .getAndCacheData(
        "${Env.digitalGuideUrl}/images/$imageID",
        (Map<String, dynamic> json) => json["image_1920w"] as String,
        ttlDays: TtlDays.defaultDigitalGuide,
        onRetry: ref.invalidateSelf,
        extraValidityCheck: (_) => true,
        localizedOfflineMessage: DigitalGuideView.localizedOfflineMessage,
        authHeader: (authotization: "Token ${Env.digitalGuideAuthorizationToken}"),
      )
      .castAsObject;
}
