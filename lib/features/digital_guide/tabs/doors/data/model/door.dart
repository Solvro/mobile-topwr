import "package:freezed_annotation/freezed_annotation.dart";

import "../../../../../../utils/type_converter.dart";

part "door.freezed.dart";
part "door.g.dart";

@freezed
abstract class Door with _$Door {
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
    @JsonKey(fromJson: stringToBool) required bool isGraphic,
    @JsonKey(fromJson: stringToBool) required bool areVisible,
    @JsonKey(fromJson: stringToBool) required bool areGlazed,
    @JsonKey(fromJson: stringToBool) required bool areOpenOutwards,
    @JsonKey(fromJson: stringToBool) required bool isClosureFromInside,
    required String openingSystemType,
    @JsonKey(fromJson: stringToBool) required bool isHandleHighlighted,
    @JsonKey(fromJson: stringToBool) required bool isSameOpeningSystem,
    @JsonKey(fromJson: stringToBool) required bool isKeyNeeded,
    @JsonKey(fromJson: stringToBool) required bool isElevatedThreshold,
    required int doorWidth,
  }) = _Door;

  factory Door.fromJson(Map<String, dynamic> json) => _$DoorFromJson(json);
}

@freezed
abstract class DoorTranslations with _$DoorTranslations {
  const factory DoorTranslations({required DoorTranslation pl}) = _DoorTranslations;

  factory DoorTranslations.fromJson(Map<String, dynamic> json) => _$DoorTranslationsFromJson(json);
}

@freezed
abstract class DoorTranslation with _$DoorTranslation {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory DoorTranslation({
    required String comment,
    required String fromTo,
    required String isMainWingHighlightedComment,
    required String isGoodDoorVisibleFromOutsideComment,
    required String isGoodDoorVisibleFromInsideComment,
    required String isIncreasedForceRequiredComment,
    required String isDoorCloserComment,
    required String handleHeight,
    required String isElevatedThresholdComment,
  }) = _DoorTranslation;

  factory DoorTranslation.fromJson(Map<String, dynamic> json) => _$DoorTranslationFromJson(json);
}

enum DoorType { singleLeafDoor, singleLeafDoorSliding, doubleLeafDoor, doubleLeafDoorSliding, swingDoor }

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
