import "package:flutter/material.dart";
import "package:intl/intl.dart";

import "../repository/getGuideDetails.graphql.dart";

extension GetTheLatestDateGuide on BuildContext {
  String? getTheLatesCreatedDateGuideX({
    List<Query$GetGuideDetails$FAQ_Types_by_id$questions?>? questions,
  }) {
    final DateTime? newestDate = questions
        ?.where((e) => e?.FAQ_id?.date_created != null)
        .map((e) => e!.FAQ_id!.date_created!)
        .reduce((a, b) => a.isAfter(b) ? a : b);

    final DateFormat formatter = DateFormat("dd.MM.yyyy");
    return newestDate != null ? formatter.format(newestDate) : null;
  }

  String? getTheLatesUpdatedDateGuideX({
    List<Query$GetGuideDetails$FAQ_Types_by_id$questions?>? questions,
  }) {
    final DateTime? newestDate = questions
        ?.where((e) => e?.FAQ_id?.date_updated != null)
        .map((e) => e!.FAQ_id!.date_updated!)
        .reduce((a, b) => a.isAfter(b) ? a : b);

    final DateFormat formatter = DateFormat("dd.MM.yyyy");
    return newestDate != null ? formatter.format(newestDate) : null;
  }
}
