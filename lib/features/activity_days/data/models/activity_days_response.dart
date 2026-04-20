import "package:freezed_annotation/freezed_annotation.dart";

part "activity_days_response.freezed.dart";
part "activity_days_response.g.dart";

@freezed
abstract class ActivityDaysResponse with _$ActivityDaysResponse {
  const factory ActivityDaysResponse({
    required int id,
    required String name,
    required DateTime startsAt,
    required DateTime endsAt,
    required DateTime createdAt,
    required DateTime updatedAt,
    ActivityDaysTimetable? timetable,
    @Default([]) List<ActivityDaysMap> maps,
    @Default([]) List<ActivityDaysLink> links,
    @Default([]) List<ActivityDaysStand> stands,
  }) = _ActivityDaysResponse;

  factory ActivityDaysResponse.fromJson(Map<String, dynamic> json) => _$ActivityDaysResponseFromJson(json);
}

@freezed
abstract class ActivityDaysTimetable with _$ActivityDaysTimetable {
  const factory ActivityDaysTimetable({
    required int id,
    String? description,
  }) = _ActivityDaysTimetable;

  factory ActivityDaysTimetable.fromJson(Map<String, dynamic> json) => _$ActivityDaysTimetableFromJson(json);
}

@freezed
abstract class ActivityDaysMap with _$ActivityDaysMap {
  const factory ActivityDaysMap({
    required int id,
    required String name,
  }) = _ActivityDaysMap;

  factory ActivityDaysMap.fromJson(Map<String, dynamic> json) => _$ActivityDaysMapFromJson(json);
}

@freezed
abstract class ActivityDaysLink with _$ActivityDaysLink {
  const factory ActivityDaysLink({
    required int id,
    required String url,
  }) = _ActivityDaysLink;

  factory ActivityDaysLink.fromJson(Map<String, dynamic> json) => _$ActivityDaysLinkFromJson(json);
}

@freezed
abstract class ActivityDaysStand with _$ActivityDaysStand {
  const factory ActivityDaysStand({
    required int id,
    required String name,
  }) = _ActivityDaysStand;

  factory ActivityDaysStand.fromJson(Map<String, dynamic> json) => _$ActivityDaysStandFromJson(json);
}
