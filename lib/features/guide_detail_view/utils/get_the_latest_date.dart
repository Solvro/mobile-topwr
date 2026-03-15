import "package:flutter/material.dart";
import "package:intl/intl.dart";
import "../data/models/guide_details.dart";

extension GetTheLatestDateGuideX on BuildContext {
  String? getTheLatesCreatedDateGuide({required GuideDetails guide, required Locale locale}) {
    final questions = guide.guideQuestions;
    final dates = [guide.createdAt, ...questions.map((e) => e.createdAt)];
    final newestDate = dates.reduce((a, b) => (a.isAfter(b)) ? a : b);
    final formatter = DateFormat("dd.MM.yyyy", locale.countryCode);
    return formatter.format(newestDate);
  }

  DateTime? getTheLatestUpdatedDateGuide({required GuideDetails guide}) {
    final questions = guide.guideQuestions;
    final dates = [guide.updatedAt, ...questions.map((e) => e.updatedAt)];
    final newestDate = dates.reduce((a, b) => (a.isAfter(b)) ? a : b);
    return newestDate;
  }
}
