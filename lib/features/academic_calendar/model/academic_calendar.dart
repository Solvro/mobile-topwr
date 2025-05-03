import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:freezed_annotation/freezed_annotation.dart";

part "academic_calendar.freezed.dart";
part "academic_calendar.g.dart";

@freezed
abstract class AcademicCalendar with _$AcademicCalendar {
  const factory AcademicCalendar({required IList<AcademicTerm> data}) = _AcademicCalendar;

  factory AcademicCalendar.fromJson(Map<String, dynamic> json) => _$AcademicCalendarFromJson(json);
}

@freezed
abstract class AcademicTerm with _$AcademicTerm {
  const factory AcademicTerm({
    required int id,
    required String name,
    required DateTime semesterStartDate,
    required DateTime examSessionStartDate,
    required DateTime examSessionLastDate,
    required bool isFirstWeekEven,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _AcademicTerm;

  factory AcademicTerm.fromJson(Map<String, dynamic> json) => _$AcademicTermFromJson(json);
}
