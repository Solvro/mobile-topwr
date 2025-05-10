import "package:freezed_annotation/freezed_annotation.dart";

part "academic_calendar_rest_model.freezed.dart";
part "academic_calendar_rest_model.g.dart";

@freezed
abstract class AcademicCalendarRestResponse with _$AcademicCalendarRestResponse {
  const factory AcademicCalendarRestResponse({required List<AcademicCalendarRestData> data}) =
      _AcademicCalendarRestResponse;

  factory AcademicCalendarRestResponse.fromJson(Map<String, dynamic> json) =>
      _$AcademicCalendarRestResponseFromJson(json);
}

@freezed
abstract class AcademicCalendarRestData with _$AcademicCalendarRestData {
  const factory AcademicCalendarRestData({
    required int id,
    required String name,
    @JsonKey(name: "semesterStartDate") required DateTime semesterStartDate,
    @JsonKey(name: "examSessionStartDate") required DateTime examSessionStartDate,
    @JsonKey(name: "examSessionLastDate") required DateTime examSessionLastDate,
    @JsonKey(name: "isFirstWeekEven") required bool isFirstWeekEven,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _AcademicCalendarRestData;

  factory AcademicCalendarRestData.fromJson(Map<String, dynamic> json) => _$AcademicCalendarRestDataFromJson(json);
}
