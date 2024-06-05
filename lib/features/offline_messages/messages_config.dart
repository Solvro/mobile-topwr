import 'package:flutter/material.dart';

import '../../config/ttl_config.dart';
import '../../utils/context_extensions.dart';

extension GqlOfflineMessage on BuildContext {
  UnmodifiableTtlKeyMap<String> _offlineMessagesLocalized() =>
      UnmodifiableTtlKeyMap(
        infosPreviewRepository: localize.offline_news,
        academicCalendarRepository: localize.offline_academic_calendar,
        sciCirclesPreviewRepository: localize.offline_sci_clubs,
        sciCirclesRepository: localize.offline_sci_clubs,
        tagsRepository: localize.offline_sci_clubs,
        mapBuildingsRepository: localize.offline_buildings,
        departmentsRepository: localize.offline_departments,
      );

  String gqlOfflineMessageLocalized(TtlKey key) {
    return "${localize.offline_error_message}${_offlineMessagesLocalized().get(key)}. ${localize.offline_try_again}";
  }
}
