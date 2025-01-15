import "package:freezed_annotation/freezed_annotation.dart";

part "digital_guide_room.freezed.dart";
part "digital_guide_room.g.dart";

@freezed
class DigitalGuideRoom with _$DigitalGuideRoom {
  const factory DigitalGuideRoom({
    required int id,
    required DigitalGuideTranslationsRoom translations,
    @JsonKey(name: "images") required List<int>? imagesIds,
  }) = _DigitalGuideRoom;

  factory DigitalGuideRoom.fromJson(Map<String, dynamic> json) =>
      _$DigitalGuideRoomFromJson(json);
}

@freezed
class DigitalGuideTranslationsRoom with _$DigitalGuideTranslationsRoom {
  const factory DigitalGuideTranslationsRoom({
    required DigitalGuideTranslationRoom pl,
  }) = _DigitalGuideTranslationsRoom;

  factory DigitalGuideTranslationsRoom.fromJson(Map<String, dynamic> json) =>
      _$DigitalGuideTranslationsRoomFromJson(json);
}

@freezed
class DigitalGuideTranslationRoom with _$DigitalGuideTranslationRoom {
  const factory DigitalGuideTranslationRoom({
    @JsonKey(name: "name") required String name,
    @JsonKey(name: "room_purpose") required String roomPurpose,
    @JsonKey(name: "location") required String location,
    @JsonKey(name: "working_days_and_hours")
    required String workingDaysAndHours,
    @JsonKey(name: "are_entrances_comment") required String areEntrancesComment,
    @JsonKey(name: "is_one_level_floor_comment")
    required String isOneLevelFloorComment,
    @JsonKey(name: "are_places_for_wheelchairs_comment")
    required String arePlacesForWheelchairsComment,
    @JsonKey(name: "comment") required String comment,
  }) = _DigitalGuideTranslationRoom;

  factory DigitalGuideTranslationRoom.fromJson(Map<String, dynamic> json) =>
      _$DigitalGuideTranslationRoomFromJson(json);
}
