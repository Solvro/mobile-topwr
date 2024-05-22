import 'package:flutter/material.dart';

import '../../api_base/ttl/ttl_config.dart';
import '../../utils/context_extensions.dart';

extension GqlOfflineMessage on BuildContext {
  UnmodifiableTtlKeyMap<String> _offlineMessagesLocalized() =>
      UnmodifiableTtlKeyMap(
        infosPreviewRepository: localize.offline_news,
        examSessionCountdownRepository: localize.offline_exam_session,
        sciCirclesPreviewRepository: localize.offline_sci_clubs,
        sciCirclesRepository: localize.offline_sci_clubs,
        tagsRepository: localize.offline_sci_clubs,
        mapBuildingsRepository: localize.offline_buildings,
        departmentsRepository: localize.offline_departments,
        weekParityExceptionsRepository: localize.offline_week_parity,
      );

  String gqlOfflineMessageLocalized(TtlKey key) {
    return "${localize.offline_error_message}${_offlineMessagesLocalized().get(key)}. ${localize.offline_try_again}";
  }
}
