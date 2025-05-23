import "package:freezed_annotation/freezed_annotation.dart";
import "package:solvro_translator_core/solvro_translator_core.dart";

part "door.freezed.dart";
part "door.g.dart";
part "door.translatable.g.dart";

@freezed
@Translatable(makeFieldsTranslatableByDefault: false)
abstract class Door with _$Door, _$DoorTranslatable {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory Door({
    @translatableField required DoorTranslations translations,
    required String isMainWingHighlighted,
    required String isGoodDoorVisibleFromOutside,
    required String isGoodDoorVisibleFromInside,
    required String areOpenAutomatically,
    required String isIncreasedForceRequired,
    required String isDoorCloser,
    @JsonKey(fromJson: stringToDoorType, toJson: doorTypeToString) required DoorType doorType,
    required String isGraphic,
    required String areVisible,
    required String areGlazed,
    required String areOpenOutwards,
    required String isClosureFromInside,
    required String openingSystemType,
    required String isHandleHighlighted,
    required String isSameOpeningSystem,
    required String isKeyNeeded,
    required String isElevatedThreshold,
    required int doorWidth,
  }) = _Door;

  const Door._();

  factory Door.fromJson(Map<String, dynamic> json) => _$DoorFromJson(json);
}

@freezed
@allFieldsTranslatable
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

String doorTypeToString(DoorType doorType) {
  return switch (doorType) {
    DoorType.singleLeafDoor => "1",
    DoorType.doubleLeafDoor => "2",
    DoorType.singleLeafDoorSliding => "3",
    DoorType.doubleLeafDoorSliding => "4",
    DoorType.swingDoor => "5",
  };
}
