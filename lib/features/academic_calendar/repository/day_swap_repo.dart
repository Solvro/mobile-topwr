import "package:freezed_annotation/freezed_annotation.dart";

part "holiday.freezed.dart";
part "holiday.g.dart";

@freezed
abstract class Holiday with _$Holiday {
  const factory Holiday({
    required int id,
    required int academicCalendarId,
    required DateTime startDate,
    required DateTime endDate,
    required String name,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _Holiday;

  factory Holiday.fromJson(Map<String, dynamic> json) => _$HolidayFromJson(json);
}

@freezed
abstract class HolidayList with _$HolidayList {
  const factory HolidayList({required List<Holiday> data}) = _HolidayList;
  factory HolidayList.fromJson(Map<String, dynamic> json) => _$HolidayListFromJson(json);
}
