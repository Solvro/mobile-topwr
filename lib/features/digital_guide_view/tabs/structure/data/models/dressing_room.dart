import "package:freezed_annotation/freezed_annotation.dart";

part "dressing_room.g.dart";
part "dressing_room.freezed.dart";

@freezed
class DressingRoom with _$DressingRoom {
  const factory DressingRoom({
    required DressingRoomTranslations translations,
  }) = _DressingRoom;

  factory DressingRoom.fromJson(Map<String, dynamic> json) => _$DressingRoomFromJson(json);
}

@freezed
class  DressingRoomTranslations with _$DressingRoomTranslations {
  const factory DressingRoomTranslations ({
    required DressingRoomTranslation plTranslation,
  }) = _DressingRoomTranslations;

  factory DressingRoomTranslations.fromJson(Map<String, dynamic> json) => _$DressingRoomTranslationsFromJson(json);
}

@freezed
class DressingRoomTranslation with _$DressingRoomTranslation {
  const factory DressingRoomTranslation ({
    required String location,
  }) = _DressingRoomTranslation;

  factory DressingRoomTranslation.fromJson(Map<String, dynamic> json) => _$DressingRoomTranslationFromJson(json);
}
