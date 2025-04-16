import "package:flutter/widgets.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:solvro_translator_core/solvro_translator_core.dart";

import "../../../../api_base_rest/client/json.dart";
import "../../../../api_base_rest/translations/translate.dart";
import "../../../../config/env.dart";
import "../../presentation/digital_guide_view.dart";

extension DigitalGuideClient on Ref {
  static const digitalGuideTTLDays = 7; // TODO(simon-the-shark): adjust it

  Future<JSON<T>> getAndCacheDataFromDigitalGuide<T extends TranslatableInterface>(
    String subUrl,
    T Function(Map<String, dynamic> json) fromJson, {
    VoidCallback? onRetry,
  }) async {
    return getAndCacheDataWithTranslation(
      "${Env.digitalGuideUrl}/$subUrl",
      digitalGuideTTLDays,
      fromJson,
      extraValidityCheck: (_) => true, // no extra validity checks for digital guide needed at the moment
      localizedOfflineMessage:
          DigitalGuideView
              .localizedOfflineMessage, // one common offline message is imo enough for the whole digital guide
      onRetry: onRetry,
      authHeader: (authotization: "Token ${Env.digitalGuideAuthorizationToken}"),
    );
  }
}
