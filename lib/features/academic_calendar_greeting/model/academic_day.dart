import 'package:freezed_annotation/freezed_annotation.dart';

import 'weekday_enum.dart';

part "academic_day.freezed.dart";
part "academic_day.g.dart";

@freezed
class AcademicDay with _$AcademicDay {
  const factory AcademicDay({
    required bool isEven,
    required WeekdayEnum weekday,
  }) = _AcademicDay;

  factory AcademicDay.fromJson(Map<String, dynamic> json) =>
      _$AcademicDayFromJson(json);
}
