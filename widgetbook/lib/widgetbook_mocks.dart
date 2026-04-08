import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:topwr/features/academic_calendar/model/academic_calendar.dart";
import "package:topwr/features/academic_calendar/repository/academic_calendar_repo.dart";
import "package:topwr/features/app_changelog/data/models/changelog.dart";
import "package:topwr/features/digital_guide/business/accessibility_comments_manager.dart";
import "package:topwr/features/digital_guide/tabs/rooms/data/models/digital_guide_room.dart";
import "package:topwr/features/digital_guide_objects/data/models/digital_guide_object_model.dart";

/// Minimal [AcademicCalendarWithSwaps] for Widgetbook stories (countdown, greeting, etc.).
final mockAcademicCalendarWithSwaps = AcademicCalendarWithSwaps(
  calendarData: AcademicCalendar(
    id: 1,
    name: "Widgetbook",
    semesterStartDate: DateTime.utc(2025, 10),
    examSessionStartDate: DateTime.utc(2026, 1, 15),
    examSessionLastDate: DateTime.utc(2026, 2, 15),
    isFirstWeekEven: true,
    createdAt: DateTime.utc(2025),
    updatedAt: DateTime.utc(2025),
  ),
  daySwaps: const IList.empty(),
);

/// Minimal [Changelog] for app changelog stories.
const mockChangelog = Changelog(name: "Widgetbook", changes: IList.empty());

/// Minimal [DigitalGuideRoom] for Widgetbook (room detail / room level lists).
const mockDigitalGuideRoom = DigitalGuideRoom(
  id: 1,
  translations: DigitalGuideTranslationsRoom(
    pl: DigitalGuideTranslationRoom(
      name: "Mock room",
      roomPurpose: "—",
      location: "—",
      workingDaysAndHours: "—",
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
    ),
  ),
  roomStairs: [],
  platforms: [],
  imagesIds: null,
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
  areMovableElements: "no",
  isRoomCausesEcho: "no",
  isNoisy: "no",
  areFlashingDevices: "no",
  hasInductionLoop: "no",
  building: 1,
  doors: [],
);

/// Minimal [DigitalGuideObjectModel] for object feature stories.
const mockDigitalGuideObjectModel = DigitalGuideObjectModel(
  id: 1,
  translations: DigitalGuideObjectTranslations(
    pl: DigitalGuideObjectTranslation(name: "Mock object", address: "Mock address"),
  ),
  isPossibilityToEnterWithAssistanceDog: false,
  isMicronavigationSystem: false,
  areGuidancePaths: false,
  areInformationBoardsWithBrailleDescription: false,
  areInformationBoardsWithLargeFont: false,
  accessibilityLevelForMotorDisability: 1,
  accessibilityLevelForBlind: 1,
  accessibilityLevelForVisuallyImpaired: 1,
  accessibilityLevelForHardOfHearing: 1,
  accessibilityLevelForHighSensorySensitivity: 1,
  accessibilityLevelForCognitiveDifficulties: 1,
  images: [],
);

/// No-op implementation for stories that only need an [AccessibilityCommentsManager] instance.
final class EmptyAccessibilityCommentsManager extends AccessibilityCommentsManager {
  EmptyAccessibilityCommentsManager();

  @override
  IList<String> getCommentsListForBlind() => const IList.empty();

  @override
  IList<String> getCommentsListForCognitiveImpairment() => const IList.empty();

  @override
  IList<String> getCommentsListForHearingImpairment() => const IList.empty();

  @override
  IList<String> getCommentsListForLowVision() => const IList.empty();

  @override
  IList<String> getCommentsListForMotorImpairment() => const IList.empty();

  @override
  IList<String> getCommentsListForSensorySensitivity() => const IList.empty();
}
