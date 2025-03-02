import "package:freezed_annotation/freezed_annotation.dart";

import "weekday_enum.dart";

part "academic_day.freezed.dart";
part "academic_day.g.dart";

@freezed
abstract class AcademicDay with _$AcademicDay {
  const factory AcademicDay({
    required bool isEven,
    required bool isHolidays,
    required bool isExamSession,
    required WeekdayEnum weekday,
  }) = _AcademicDay;

  factory AcademicDay.fromJson(Map<String, dynamic> json) => _$AcademicDayFromJson(json);
}
