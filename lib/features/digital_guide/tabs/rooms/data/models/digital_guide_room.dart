import "package:freezed_annotation/freezed_annotation.dart";
import "package:translatable_generator/index.dart";

part "digital_guide_room.freezed.dart";
part "digital_guide_room.g.dart";
part "digital_guide_room.translatable.g.dart";

@freezed
@Translatable(makeFieldsTranslatableByDefault: false)
abstract class DigitalGuideRoom with _$DigitalGuideRoom, _$DigitalGuideRoomTranslatable {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory DigitalGuideRoom({
    required int id,
    @translatableField required DigitalGuideTranslationsRoom translations,
    required List<int> roomStairs,
    required List<int> platforms,
    @JsonKey(name: "images") required List<int>? imagesIds,
    required int orderNumber,
    required String areEntrances,
    required String isUseRestricted,
    required String isOneLevelFloor,
    required String areSeats,
    required String areDimensionsAllowFreeMovement,
    required String arePlacesForWheelchairs,
    required String arePlacesAccessibleFromMainEntrance,
    required String areAnyDangerousElements,
    required String isGenerallyAvailableDesk,
    required String isSpaceUnderCounter,
    required String areElectricalOutlets,
    required String isGoodFloorRoomContrast,
    required String isGoodLit,
    required String isFloorShiny,
    required String isBlackboard,
    required String areMovableElements,
    required String isRoomCausesEcho,
    required String isNoisy,
    required String areFlashingDevices,
    required String hasInductionLoop,
    required int building,
    required List<int> doors,
  }) = _DigitalGuideRoom;

  const DigitalGuideRoom._();

  factory DigitalGuideRoom.fromJson(Map<String, dynamic> json) => _$DigitalGuideRoomFromJson(json);
}

@freezed
@allFieldsTranslatable
abstract class DigitalGuideTranslationsRoom with _$DigitalGuideTranslationsRoom {
  const factory DigitalGuideTranslationsRoom({required DigitalGuideTranslationRoom pl}) = _DigitalGuideTranslationsRoom;

  factory DigitalGuideTranslationsRoom.fromJson(Map<String, dynamic> json) =>
      _$DigitalGuideTranslationsRoomFromJson(json);
}

@freezed
abstract class DigitalGuideTranslationRoom with _$DigitalGuideTranslationRoom {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory DigitalGuideTranslationRoom({
    required String name,
    required String roomPurpose,
    required String location,
    required String workingDaysAndHours,
    required String areEntrancesComment,
    required String isUseRestrictedComment,
    required String isOneLevelFloorComment,
    required String areSeatsComment,
    required String areDimensionsAllowFreeMovementComment,
    required String arePlacesForWheelchairsComment,
    required String arePlacesAccessibleFromMainEntranceComment,
    required String areAnyDangerousElementsComment,
    required String isGenerallyAvailableDeskComment,
    required String isSpaceUnderCounterComment,
    required String areElectricalOutletsComment,
    required String isGoodFloorRoomContrastComment,
    required String isGoodLitComment,
    required String isFloorShinyComment,
    required String isBlackboardComment,
    required String areMovableElementsComment,
    required String isRoomCausesEchoComment,
    required String isNoisyComment,
    required String areFlashingDevicesComment,
    required String hasInductionLoopComment,
    required String comment,
  }) = _DigitalGuideTranslationRoom;

  factory DigitalGuideTranslationRoom.fromJson(Map<String, dynamic> json) =>
      _$DigitalGuideTranslationRoomFromJson(json);
}
