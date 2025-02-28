import "package:freezed_annotation/freezed_annotation.dart";

part "room_platforms_response.freezed.dart";
part "room_platforms_response.g.dart";

@freezed
class RoomPlatformsResponse with _$RoomPlatformsResponse {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory RoomPlatformsResponse({
    required int id,
    required RoomPlatformsTranslations translations,
    required String isGoodFloorPlatformContrast,
    required String haveAccessForPeopleInWheelchair,
    required String isPlatformEntranceMarked,
    required String areNoObjectsNarrowCommunicationZone,
  }) = _RoomPlatformsResponse;

  factory RoomPlatformsResponse.fromJson(Map<String, dynamic> json) => _$RoomPlatformsResponseFromJson(json);
}

@freezed
class RoomPlatformsTranslations with _$RoomPlatformsTranslations {
  const factory RoomPlatformsTranslations({required RoomPlatformsTranslation pl}) = _RoomPlatformsTranslations;

  factory RoomPlatformsTranslations.fromJson(Map<String, dynamic> json) => _$RoomPlatformsTranslationsFromJson(json);
}

@freezed
class RoomPlatformsTranslation with _$RoomPlatformsTranslation {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory RoomPlatformsTranslation({
    required String location,
    required String platformDimensions,
    required String areStepsLeadingToThePlatform,
    required String comment,
    required String isGoodFloorPlatformContrastComment,
    required String haveAccessForPeopleInWheelchairComment,
    required String isPlatformEntranceMarkedComment,
    required String areNoObjectsNarrowCommunicationZoneComment,
  }) = _RoomPlatformTranslation;

  factory RoomPlatformsTranslation.fromJson(Map<String, dynamic> json) => _$RoomPlatformsTranslationFromJson(json);
}
