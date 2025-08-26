import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/material.dart";
import "package:intl/intl.dart";
import "../data/models/guide_details.dart";

extension GetTheLatestDateGuideX on BuildContext {
  String getTheLatesCreatedDateGuide({required IList<GuideQuestion> questions, required Locale locale}) {
    final newestDate = questions.map((e) => e.createdAt).reduce((a, b) => (a.isAfter(b)) ? a : b);
    final formatter = DateFormat("dd.MM.yyyy", locale.countryCode);
    return formatter.format(newestDate);
  }

  DateTime getTheLatestUpdatedDateGuide({required IList<GuideQuestion> questions}) {
    final newestDate = questions.map((e) => e.updatedAt).reduce((a, b) => (a.isAfter(b)) ? a : b);
    return newestDate;
  }
}
