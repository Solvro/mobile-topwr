import "package:freezed_annotation/freezed_annotation.dart";

part "door.freezed.dart";
part "door.g.dart";

@freezed
class Door with _$Door {
  const factory Door({
    required DoorTranslations translations,
    @JsonKey(name: "is_main_wing_highlighted") required String isMainWingHighlighted,
    @JsonKey(name: "is_good_door_visible_from_outside") required String isGoodDoorVisibleFromOutside,
    @JsonKey(name: "is_good_door_visible_from_inside") required String isGoodDoorVisibleFromInside,
    @JsonKey(name: "are_open_automatically") required String areOpenAutomatically,
    @JsonKey(name: "is_increased_force_required") required String isIncreasedForceRequired,
    @JsonKey(name: "is_door_closer") required String isDoorCloser,
    @JsonKey(name: "door_type", fromJson: stringToDoorType) required DoorType doorType,
  }) = _Door;

  factory Door.fromJson(Map<String, dynamic> json) =>
    _$DoorFromJson(json);
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
  const factory DoorTranslation({
    required String comment,
    @JsonKey(name: "from_to") required String fromTo,
    @JsonKey(name: "is_main_wing_highlighted_comment") required String isMainWingHighlightedComment,
    @JsonKey(name: "is_good_door_visible_from_outside_comment") required String isGoodDoorVisibleFromOutsideComment,
    @JsonKey(name: "is_good_door_visible_from_inside_comment") required String isGoodDoorVisibleFromInsideComment,
    @JsonKey(name: "is_increased_force_required_comment") required String isIncreasedForceRequiredComment,
    @JsonKey(name: "is_door_closer_comment") required String isDoorCloserComment
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
