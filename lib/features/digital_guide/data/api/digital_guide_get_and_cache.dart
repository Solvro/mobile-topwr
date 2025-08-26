import "package:flutter/widgets.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:solvro_translator_core/solvro_translator_core.dart";

import "../../../../api_base_rest/client/json.dart";
import "../../../../api_base_rest/translations/translate.dart";
import "../../../../config/env.dart";
import "../../../../config/ttl_config.dart";
import "../../presentation/digital_guide_view.dart";

extension DigitalGuideClient on Ref {
  Future<JSON<T>> getAndCacheDataFromDigitalGuide<T extends TranslatableInterface>(
    String subUrl,
    T Function(Map<String, dynamic> json) fromJson, {
    VoidCallback? onRetry,
  }) {
    return getAndCacheDataWithTranslation(
      "${Env.digitalGuideUrl}/$subUrl",
      fromJson,
      ttlDays: TtlDays.defaultDigitalGuide,
      extraValidityCheck: (_) => true, // no extra validity checks for digital guide needed at the moment
      localizedOfflineMessage: DigitalGuideView
          .localizedOfflineMessage, // one common offline message is imo enough for the whole digital guide
      onRetry: onRetry,
      authHeader: (authotization: "Token ${Env.digitalGuideAuthorizationToken}"),
    );
  }
}
