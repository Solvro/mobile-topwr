import "package:flutter/material.dart";
import "package:intl/intl.dart";

import "../../../utils/where_non_null_iterable.dart";
import "../repository/getGuideDetails.graphql.dart";

extension GetTheLatestDateGuide on BuildContext {
  String? getTheLatesCreatedDateGuideX({
    List<Query$GetGuideDetails$FAQ_Types_by_id$questions?>? questions,
  }) {
    final DateTime? newestDate = questions
        ?.whereNonNull
        .map((e) => e.FAQ_id!.date_created!)
        .reduce((a, b) => a.isAfter(b) ? a : b);

    final DateFormat formatter = DateFormat("dd.MM.yyyy");
    return newestDate != null ? formatter.format(newestDate) : null;
  }

  String? getTheLatesUpdatedDateGuideX({
    List<Query$GetGuideDetails$FAQ_Types_by_id$questions?>? questions,
  }) {
    final DateTime? newestDate = questions
        ?.whereNonNull
        .map((e) => e.FAQ_id!.date_updated!)
        .reduce((a, b) => a.isAfter(b) ? a : b);

    final DateFormat formatter = DateFormat("dd.MM.yyyy");
    return newestDate != null ? formatter.format(newestDate) : null;
  }
}
