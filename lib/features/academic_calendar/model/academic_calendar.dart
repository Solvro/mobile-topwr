import "package:freezed_annotation/freezed_annotation.dart";

part "academic_calendar.freezed.dart";
part "academic_calendar.g.dart";

@freezed
abstract class AcademicCalendarResponse with _$AcademicCalendarResponse {
  const factory AcademicCalendarResponse({required List<AcademicCalendar> data}) = _AcademicCalendarResponse;

  factory AcademicCalendarResponse.fromJson(Map<String, dynamic> json) => _$AcademicCalendarResponseFromJson(json);
}

@freezed
abstract class AcademicCalendar with _$AcademicCalendar {
  const factory AcademicCalendar({
    required int id,
    required String name,
    required DateTime semesterStartDate,
    required DateTime examSessionStartDate,
    required DateTime examSessionLastDate,
    required bool isFirstWeekEven,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _AcademicCalendar;

  factory AcademicCalendar.fromJson(Map<String, dynamic> json) => _$AcademicCalendarFromJson(json);
}
