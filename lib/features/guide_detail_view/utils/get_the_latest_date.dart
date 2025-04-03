import "package:flutter/material.dart";
import "package:intl/intl.dart";

import "../../../utils/context_extensions.dart";
import "../../../utils/where_non_null_iterable.dart";
import "../repository/getGuideDetails.graphql.dart";

extension GetTheLatestDateGuideX on BuildContext {
  String? getTheLatesCreatedDateGuide({List<Query$GetGuideDetails$FAQ_Types_by_id$questions?>? questions}) {
    final newestDate = questions?.whereNonNull
        .map((e) => e.FAQ_id?.date_created)
        .reduce((a, b) => (b == null || a != null && a.isAfter(b)) ? a : b);
    final formatter = DateFormat("dd.MM.yyyy", locale.countryCode);
    return newestDate != null ? formatter.format(newestDate) : null;
  }

  DateTime? getTheLatesUpdatedDateGuide({List<Query$GetGuideDetails$FAQ_Types_by_id$questions?>? questions}) {
    final newestDate = questions?.whereNonNull
        .map((e) => e.FAQ_id?.date_updated)
        .reduce((a, b) => (b == null || a != null && a.isAfter(b)) ? a : b);
    return newestDate;
  }
}
