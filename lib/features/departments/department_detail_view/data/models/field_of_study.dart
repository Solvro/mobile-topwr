import "package:freezed_annotation/freezed_annotation.dart";

part "field_of_study.freezed.dart";
part "field_of_study.g.dart";

@freezed
abstract class FieldOfStudy with _$FieldOfStudy {
  const factory FieldOfStudy({
    required String name,
    required String url,
    required bool isEnglish,
    required bool is2ndDegree,
    required bool hasWeekendOptions,
  }) = _FieldOfStudy;

  factory FieldOfStudy.fromJson(Map<String, dynamic> json) => _$FieldOfStudyFromJson(json);
}
