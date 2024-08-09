import "package:flutter/material.dart";

import "../../config/ttl_config.dart";
import "../../utils/context_extensions.dart";

extension GqlOfflineMessageX on BuildContext {
  UnmodifiableTtlKeyMap<String> _offlineMessagesLocalized() =>
      UnmodifiableTtlKeyMap(
        academicCalendarRepository: localize.offline_academic_calendar,
        scienceClubDetailsRepository: localize.offline_sci_clubs,
        scienceClubsRepository: localize.offline_sci_clubs,
        tagsRepository: localize.offline_sci_clubs,
        buildingsRepository: localize.offline_buildings,
        departmentsRepository: localize.offline_departments,
        aboutUsRepository: localize.offline_about_us,
        departmentDetailsRepository: localize.offline_department_details,
        guideDetailsRepository: localize.offline_guide_details,
        guideViewRepository: localize.offline_guide_posts,
      );

  String gqlOfflineMessageLocalized(TtlKey key) {
    return "${localize.offline_error_message}${_offlineMessagesLocalized().get(key)}. ${localize.offline_try_again}";
  }
}
