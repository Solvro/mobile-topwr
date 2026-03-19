import "package:flutter/widgets.dart";
import "package:topwr/features/digital_guide/tabs/rooms/data/models/digital_guide_room.dart";
import "package:topwr/features/digital_guide/tabs/rooms/presentation/digital_guide_room_detail_view.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

@widgetbook.UseCase(name: "default", type: DigitalGuideRoomDetailView)
Widget useCaseDigitalGuideRoomDetailView(BuildContext context) {
  // Mock translation room (PL locale example)
  const mockTranslation = DigitalGuideTranslationRoom(
    name: "",
    roomPurpose: "",
    location: "",
    workingDaysAndHours: "",
    areEntrancesComment: "",
    isUseRestrictedComment: "",
    isOneLevelFloorComment: "",
    areSeatsComment: "",
    areDimensionsAllowFreeMovementComment: "",
    arePlacesForWheelchairsComment: "",
    arePlacesAccessibleFromMainEntranceComment: "",
    areAnyDangerousElementsComment: "",
    isGenerallyAvailableDeskComment: "",
    isSpaceUnderCounterComment: "",
    areElectricalOutletsComment: "",
    isGoodFloorRoomContrastComment: "",
    isGoodLitComment: "",
    isFloorShinyComment: "",
    isBlackboardComment: "",
    areMovableElementsComment: "",
    isRoomCausesEchoComment: "",
    isNoisyComment: "",
    areFlashingDevicesComment: "",
    hasInductionLoopComment: "",
    comment: "",
  );
  const mockTranslations = DigitalGuideTranslationsRoom(pl: mockTranslation);

  const mockRoom = DigitalGuideRoom(
    id: 0,
    translations: mockTranslations,
    roomStairs: [],
    platforms: [],
    imagesIds: [],
    orderNumber: 0,
    areEntrances: "false",
    isUseRestricted: "false",
    isOneLevelFloor: "false",
    areSeats: "false",
    areDimensionsAllowFreeMovement: "false",
    arePlacesForWheelchairs: "false",
    arePlacesAccessibleFromMainEntrance: "false",
    areAnyDangerousElements: "false",
    isGenerallyAvailableDesk: "false",
    isSpaceUnderCounter: "false",
    areElectricalOutlets: "false",
    isGoodFloorRoomContrast: "false",
    isGoodLit: "false",
    isFloorShiny: "false",
    isBlackboard: "false",
    areMovableElements: "false",
    isRoomCausesEcho: "false",
    isNoisy: "false",
    areFlashingDevices: "false",
    hasInductionLoop: "false",
    building: 0,
    doors: [],
  );

  return const DigitalGuideRoomDetailView(room: mockRoom);
}
