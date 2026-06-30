import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/widgets.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:topwr/features/digital_guide/data/models/digital_guide_response.dart";
import "package:topwr/features/digital_guide/tabs/entraces/data/models/digital_guide_entrace.dart";
import "package:topwr/features/digital_guide/tabs/entraces/data/repository/entraces_repository.dart";
import "package:topwr/features/digital_guide/tabs/evacuation/evacuation_widget.dart";
import "package:widgetbook/widgetbook.dart";

part "evacuation_widget.stories.g.dart";

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
  phoneNumbers: ["123456789", "987654321"],
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

const meta = Meta(EvacuationWidget.new);

const _mockEntrance = DigitalGuideEntrace(
  id: 1,
  translations: DigitalGuideTranslationsEntrace(
    pl: DigitalGuideTranslationEntrace(
      name: "Main Entrance",
      location: "Ground floor, north side",
      isMainComment: "Main building entry",
      isForPersonelComment: "Available for all visitors",
      isBuildingMarkedFromEntranceComment: "Marked by clear signage",
      isBuildingMarkedInEnComment: "English signs available",
      isLitComment: "Well lit",
      isEmergencyExitComment: "Not emergency-only",
      isProtectionFromWeatherComment: "Covered by roof",
      isSolidSurfaceComment: "Paved access",
      areDifferentTypesOfSurfaceComment: "No problematic transitions",
      areBenchesComment: "Bench nearby",
      entranceThreats: "None",
      hasSoundTransmitterComment: "Beacon available",
      hasTactilePavingComment: "Tactile paving to door",
      comment: "Automatic door available",
    ),
  ),
  orderNumber: 1,
  isMain: "yes",
  isAccessible: "yes",
  isForPersonel: "no",
  isBuildingMarkedFromEntrance: "yes",
  isBuildingMarkedInEn: "yes",
  isLit: "yes",
  isEmergencyExit: "no",
  isProtectionFromWeather: "yes",
  isSolidSurface: "yes",
  areDifferentTypesOfSurface: "no",
  areBenches: "yes",
  numberOfDoors: 1,
  doorsDistance: "1.2 m",
  hasSoundTransmitter: "yes",
  hasTactilePaving: "yes",
  building: 1,
  stairsIndices: IListConst([]),
  liftsIndices: IListConst([]),
  doorsIndices: IListConst([]),
  rampsIndices: IListConst([]),
  imagesIndices: IListConst([101]),
);

final $default = EvacuationWidgetStory(
  setup: (context, child, args) => ProviderScope(
    key: ValueKey("evacuation-${args.digitalGuideData.id}"),
    overrides: [
      entrancesRepositoryProvider.overrideWith((ref, building) => const IListConst([_mockEntrance])),
    ],
    child: child,
  ),
  args: EvacuationWidgetArgs(digitalGuideData: Arg.fixed(_mockDigitalGuideData)),
);
