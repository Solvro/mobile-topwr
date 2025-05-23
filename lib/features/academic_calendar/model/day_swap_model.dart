import "package:freezed_annotation/freezed_annotation.dart";

part "day_swap_model.freezed.dart";
part "day_swap_model.g.dart";

@freezed
abstract class DaySwapResponse with _$DaySwapResponse {
  const factory DaySwapResponse({required List<DaySwapData> data}) = _DaySwapResponse;

  factory DaySwapResponse.fromJson(Map<String, dynamic> json) => _$DaySwapResponseFromJson(json);
}

@freezed
abstract class DaySwapData with _$DaySwapData {
  const factory DaySwapData({
    required int id,
    required int academicCalendarId,
    required DateTime date,
    required String changedWeekday,
    required bool changedDayIsEven,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _DaySwapData;

  factory DaySwapData.fromJson(Map<String, dynamic> json) => _$DaySwapDataFromJson(json);
}
