import "package:freezed_annotation/freezed_annotation.dart";

part "day_swap.freezed.dart";
part "day_swap.g.dart";

@freezed
abstract class DaySwap with _$DaySwap {
  const factory DaySwap({
    required int id,
    required int academicCalendarId,
    required DateTime date,
    required String changedWeekday,
    required bool changedDayIsEven,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _DaySwap;

  factory DaySwap.fromJson(Map<String, dynamic> json) => _$DaySwapFromJson(json);
}

@freezed
abstract class DaySwapList with _$DaySwapList {
  const factory DaySwapList({required List<DaySwap> data}) = _DaySwapList;
  factory DaySwapList.fromJson(Map<String, dynamic> json) => _$DaySwapListFromJson(json);
}
