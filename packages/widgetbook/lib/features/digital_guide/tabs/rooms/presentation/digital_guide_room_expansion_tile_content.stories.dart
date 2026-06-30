import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/widgets.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:topwr/features/digital_guide/data/models/digital_guide_response.dart";
import "package:topwr/features/digital_guide/data/models/level.dart";
import "package:topwr/features/digital_guide/tabs/rooms/data/models/digital_guide_room.dart";
import "package:topwr/features/digital_guide/tabs/rooms/domain/digital_guide_rooms_use_cases.dart";
import "package:topwr/features/digital_guide/tabs/rooms/presentation/digital_guide_rooms_expansion_tile_content.dart";
import "package:widgetbook/widgetbook.dart";

part "digital_guide_room_expansion_tile_content.stories.g.dart";

const _mockDigitalGuideData = DigitalGuideResponse(
  id: 1,
  externalId: 100,
  translations: DigitalGuideTranslations(
    plTranslation: DigitalGuideTranslation(
      name: "Building A",
      extendedName: "Main Academic Building",
      address: "Wyb. Wyspiańskiego 23-25, 50-370 Wrocław",
      evacuationDescription: "Use main stairs",
    ),
  ),
  numberOfStoreys: 5,
  canAssistanceDog: true,
  isInductionLoop: true,
  isMicroNavigationSystem: false,
  areGuidancePaths: true,
  areBrailleBoards: true,
  areLargeFontBoards: true,
  isSignLanguageInterpreter: false,
  areEmergencyChairs: true,
  phoneNumbers: ["123456789"],
  surroundingId: 1,
  images: [1, 2, 3],
  evacuationMapId: 1,
  locationMapId: 1,
  levelsIndices: [0, 1, 2, 3, 4],
  accessId: 1,
  accessibilityLevelForMotorDisability: 1,
  accessibilityLevelForBlind: 2,
  accessibilityLevelForVisuallyImpaired: 2,
  accessibilityLevelForHardOfHearing: 1,
  accessibilityLevelForHighSensorySensitivity: 1,
  accessibilityLevelForCognitiveDifficulties: 1,
);

const meta = Meta(DigitalGuideRoomExpansionTileContent.new);

const _mockLevel = Level(
  id: 1,
  floorNumber: 0,
  translations: LevelTranslations(
    plTranslation: LevelTranslation(name: "Ground floor", roomNumbersRange: "001-050"),
  ),
  regionIndices: [1],
);

const _mockRoom = DigitalGuideRoom(
  id: 1,
  translations: DigitalGuideTranslationsRoom(
    pl: DigitalGuideTranslationRoom(
      name: "Room 101",
      roomPurpose: "Lecture room",
      location: "Ground floor, near main hall",
      workingDaysAndHours: "Mon-Fri 08:00-20:00",
      areEntrancesComment: "One main entrance",
      isUseRestrictedComment: "Open for students",
      isOneLevelFloorComment: "Flat floor",
      areSeatsComment: "Chairs available",
      areDimensionsAllowFreeMovementComment: "Enough free movement space",
      arePlacesForWheelchairsComment: "Dedicated wheelchair spaces",
      arePlacesAccessibleFromMainEntranceComment: "Accessible from main entrance",
      areAnyDangerousElementsComment: "No dangerous elements",
      isGenerallyAvailableDeskComment: "Lecturer desk accessible",
      isSpaceUnderCounterComment: "Space under desk available",
      areElectricalOutletsComment: "Outlets available",
      isGoodFloorRoomContrastComment: "Good floor-wall contrast",
      isGoodLitComment: "Well lit",
      isFloorShinyComment: "Matte floor",
      isBlackboardComment: "Whiteboard available",
      areMovableElementsComment: "Some movable furniture",
      isRoomCausesEchoComment: "Low echo",
      isNoisyComment: "Low noise level",
      areFlashingDevicesComment: "No flashing devices",
      hasInductionLoopComment: "Induction loop available",
      comment: "Sample room for Widgetbook",
    ),
  ),
  roomStairs: [],
  platforms: [],
  imagesIds: [101],
  orderNumber: 1,
  areEntrances: "yes",
  isUseRestricted: "no",
  isOneLevelFloor: "yes",
  areSeats: "yes",
  areDimensionsAllowFreeMovement: "yes",
  arePlacesForWheelchairs: "yes",
  arePlacesAccessibleFromMainEntrance: "yes",
  areAnyDangerousElements: "no",
  isGenerallyAvailableDesk: "yes",
  isSpaceUnderCounter: "yes",
  areElectricalOutlets: "yes",
  isGoodFloorRoomContrast: "yes",
  isGoodLit: "yes",
  isFloorShiny: "no",
  isBlackboard: "yes",
  areMovableElements: "yes",
  isRoomCausesEcho: "no",
  isNoisy: "no",
  areFlashingDevices: "no",
  hasInductionLoop: "yes",
  building: 1,
  doors: [],
);

final $default = DigitalGuideRoomExpansionTileContentStory(
  setup: (context, child, args) => ProviderScope(
    key: ValueKey("rooms-${args.digitalGuideResponse.id}"),
    overrides: [
      getLevelsWithRoomsUseCaseProvider.overrideWith(
        (ref, digitalGuideData) => const IListConst([
          (level: _mockLevel, rooms: IListConst([_mockRoom])),
        ]),
      ),
    ],
    child: child,
  ),
  args: DigitalGuideRoomExpansionTileContentArgs(digitalGuideResponse: Arg.fixed(_mockDigitalGuideData)),
);
