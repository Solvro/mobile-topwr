import "package:freezed_annotation/freezed_annotation.dart";

part "field_of_study.freezed.dart";
part "field_of_study.g.dart";

const longCycleStudiesSemesterCount = 12;

@freezed
abstract class FieldOfStudy with _$FieldOfStudy {
  const factory FieldOfStudy({
    required String name,
    required String url,
    required int semesterCount,
    required bool isEnglish,
    required bool is2ndDegree,
    required bool hasWeekendOption,
  }) = _FieldOfStudy;

  factory FieldOfStudy.fromJson(Map<String, dynamic> json) => _$FieldOfStudyFromJson(json);
}

extension CycleStudiesFormatterX on FieldOfStudy {
  bool get isLongCycleStudies {
    return semesterCount == longCycleStudiesSemesterCount;
  }
}
