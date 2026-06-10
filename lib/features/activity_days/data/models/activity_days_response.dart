import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:freezed_annotation/freezed_annotation.dart";

part "activity_days_response.freezed.dart";
part "activity_days_response.g.dart";

@freezed
abstract class ActivityDaysListResponse with _$ActivityDaysListResponse {
  const factory ActivityDaysListResponse(IList<ActivityDaysResponse> data) = _ActivityDaysListResponse;

  factory ActivityDaysListResponse.fromJson(Map<String, dynamic> json) => _$ActivityDaysListResponseFromJson(json);
}

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
    @Default(IListConst([])) IList<ActivityDaysMap> maps,
    @Default(IListConst([])) IList<ActivityDaysLink> links,
    @Default(IListConst([])) IList<ActivityDaysStand> stands,
  }) = _ActivityDaysResponse;

  factory ActivityDaysResponse.fromJson(Map<String, dynamic> json) => _$ActivityDaysResponseFromJson(json);
}

@freezed
abstract class ActivityDaysTimetable with _$ActivityDaysTimetable {
  const factory ActivityDaysTimetable({
    required int id,
    String? description,
    @Default(IListConst([])) IList<ActivityDaysTimetableEntry> entries,
  }) = _ActivityDaysTimetable;

  factory ActivityDaysTimetable.fromJson(Map<String, dynamic> json) => _$ActivityDaysTimetableFromJson(json);
}

@freezed
abstract class ActivityDaysTimetableEntry with _$ActivityDaysTimetableEntry {
  const factory ActivityDaysTimetableEntry({
    required int id,
    required String name,
    required DateTime startTime,
    DateTime? endTime,
  }) = _ActivityDaysTimetableEntry;

  factory ActivityDaysTimetableEntry.fromJson(Map<String, dynamic> json) => _$ActivityDaysTimetableEntryFromJson(json);
}

@freezed
abstract class ActivityDaysMap with _$ActivityDaysMap {
  const factory ActivityDaysMap({required int id, required String name}) = _ActivityDaysMap;

  factory ActivityDaysMap.fromJson(Map<String, dynamic> json) => _$ActivityDaysMapFromJson(json);
}

@freezed
abstract class ActivityDaysLink with _$ActivityDaysLink {
  const factory ActivityDaysLink({required int id, required String url}) = _ActivityDaysLink;

  factory ActivityDaysLink.fromJson(Map<String, dynamic> json) => _$ActivityDaysLinkFromJson(json);
}

@freezed
abstract class ActivityDaysStand with _$ActivityDaysStand {
  const factory ActivityDaysStand({required int id, required String name}) = _ActivityDaysStand;

  factory ActivityDaysStand.fromJson(Map<String, dynamic> json) => _$ActivityDaysStandFromJson(json);
}
