import "package:freezed_annotation/freezed_annotation.dart";

part "day_swap_rest_model.freezed.dart";
part "day_swap_rest_model.g.dart";

@freezed
abstract class DaySwapRestResponse with _$DaySwapRestResponse {
  const factory DaySwapRestResponse({required List<DaySwapRestData> data}) = _DaySwapRestResponse;

  factory DaySwapRestResponse.fromJson(Map<String, dynamic> json) => _$DaySwapRestResponseFromJson(json);
}

@freezed
abstract class DaySwapRestData with _$DaySwapRestData {
  const factory DaySwapRestData({
    required int id,
    required int academicCalendarId,
    required DateTime date,
    @JsonKey(name: "changedWeekday") required String changedWeekday,
    @JsonKey(name: "changedDayIsEven") required bool changedDayIsEven,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _DaySwapRestData;

  factory DaySwapRestData.fromJson(Map<String, dynamic> json) => _$DaySwapRestDataFromJson(json);
}
