import "package:freezed_annotation/freezed_annotation.dart";

part "door.freezed.dart";
part "door.g.dart";

@freezed
class Door with _$Door {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory Door({
    required DoorTranslations translations,
    required String isMainWingHighlighted,
    required String isGoodDoorVisibleFromOutside,
    required String isGoodDoorVisibleFromInside,
    required String areOpenAutomatically,
    required String isIncreasedForceRequired,
    required String isDoorCloser,
    @JsonKey(fromJson: stringToDoorType) required DoorType doorType,
  }) = _Door;

  factory Door.fromJson(Map<String, dynamic> json) => _$DoorFromJson(json);
}

@freezed
class DoorTranslations with _$DoorTranslations {
  const factory DoorTranslations({
    required DoorTranslation pl,
  }) = _DoorTranslations;

  factory DoorTranslations.fromJson(Map<String, dynamic> json) =>
      _$DoorTranslationsFromJson(json);
}

@freezed
class DoorTranslation with _$DoorTranslation {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory DoorTranslation({
    required String comment,
    required String fromTo,
    required String isMainWingHighlightedComment,
    required String isGoodDoorVisibleFromOutsideComment,
    required String isGoodDoorVisibleFromInsideComment,
    required String isIncreasedForceRequiredComment,
    required String isDoorCloserComment,
  }) = _DoorTranslation;

  factory DoorTranslation.fromJson(Map<String, dynamic> json) =>
      _$DoorTranslationFromJson(json);
}

enum DoorType {
  singleLeafDoor,
  singleLeafDoorSliding,
  doubleLeafDoor,
  doubleLeafDoorSliding,
  swingDoor,
}

DoorType stringToDoorType(String string) {
  switch (string) {
    case "1":
      return DoorType.singleLeafDoor;
    case "2":
      return DoorType.doubleLeafDoor;
    case "3":
      return DoorType.singleLeafDoorSliding;
    case "4":
      return DoorType.doubleLeafDoorSliding;
    case "5":
      return DoorType.swingDoor;
    default:
      return DoorType.singleLeafDoor;
  }
}
