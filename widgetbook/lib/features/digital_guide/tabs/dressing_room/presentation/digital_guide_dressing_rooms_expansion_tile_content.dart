import "package:flutter/widgets.dart";
import "package:topwr/features/digital_guide/data/models/digital_guide_response.dart";
import "package:topwr/features/digital_guide/tabs/dressing_room/presentation/digital_guide_dressing_rooms_expansion_tile.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

const mockDigitalGuideResponse = DigitalGuideResponse(
  id: 1,
  externalId: 123,
  translations: DigitalGuideTranslations(
    plTranslation: DigitalGuideTranslation(
      name: "Mock name",
      extendedName: "Mock ext name",
      address: "Mock address",
      evacuationDescription: "Evac desc",
    ),
  ),
  numberOfStoreys: 3,
  canAssistanceDog: false,
  isInductionLoop: false,
  isMicroNavigationSystem: false,
  areGuidancePaths: false,
  areBrailleBoards: false,
  areLargeFontBoards: false,
  isSignLanguageInterpreter: false,
  areEmergencyChairs: false,
  phoneNumbers: ["111222333"],
  surroundingId: 42,
  images: [],
  evacuationMapId: 1,
  locationMapId: 2,
  levelsIndices: [],
  accessId: 1,
  accessibilityLevelForMotorDisability: 0,
  accessibilityLevelForBlind: 0,
  accessibilityLevelForVisuallyImpaired: 0,
  accessibilityLevelForHardOfHearing: 0,
  accessibilityLevelForHighSensorySensitivity: 0,
  accessibilityLevelForCognitiveDifficulties: 0,
);

@widgetbook.UseCase(name: "default-mock", type: DigitalGuideDressingRoomsExpansionTileContent)
Widget useCaseDigitalGuideDressingRoomsExpansionTileContent(BuildContext context) {
  return const DigitalGuideDressingRoomsExpansionTileContent(mockDigitalGuideResponse);
}
