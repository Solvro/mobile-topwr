import "package:flutter/material.dart";

import "../../config/ttl_config.dart";
import "../../utils/context_extensions.dart";

extension GqlOfflineMessageX on BuildContext {
  String _offlineMessagesLocalized(TtlKey key) => switch (key) {
        TtlKey.academicCalendarRepository => localize.offline_academic_calendar,
        TtlKey.scienceClubDetailsRepository => localize.offline_sci_clubs,
        TtlKey.scienceClubsRepository => localize.offline_sci_clubs,
        TtlKey.tagsRepository => localize.offline_sci_clubs,
        TtlKey.buildingsRepository => localize.offline_buildings,
        TtlKey.departmentsRepository => localize.offline_departments,
        TtlKey.aboutUsRepository => localize.offline_about_us,
        TtlKey.departmentDetailsRepository =>
          localize.offline_department_details,
        TtlKey.guideDetailsRepository => localize.offline_guide_details,
        TtlKey.guideRepository => localize.offline_guide_posts,
        TtlKey.changelogRepository => "",
      };

  String gqlOfflineMessageLocalized(TtlKey key) {
    return "${localize.offline_error_message}${_offlineMessagesLocalized(key)}. ${localize.offline_try_again}";
  }
}
