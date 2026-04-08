import "package:topwr/features/branches/data/model/branch.dart";
import "package:topwr/features/digital_guide/data/models/digital_guide_response.dart";
import "package:topwr/features/digital_guide/presentation/widgets/digital_guide_features_section.dart";
import "package:topwr/features/multilayer_map/data/model/building.dart";
import "package:widgetbook/widgetbook.dart";

part "digital_guide_features_section.stories.g.dart";

const _mockDigitalGuideData = DigitalGuideResponse(
  id: 1,
  externalId: 100,
  translations: DigitalGuideTranslations(
    plTranslation: DigitalGuideTranslation(
      name: "Building A",
      extendedName: "Main Academic Building",
      address: "Wroclaw, Main Street 1",
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

const _mockBuilding = Building(
  rawId: 1,
  name: "Building A",
  naturalName: "Main Building",
  addressLine1: "Main Street 1",
  addressLine2: "50-123 Wroclaw",
  latitude: 51.1,
  longitude: 16.9,
  externalDigitalGuideMode: ExternalDigitalGuideMode.webUrl,
  externalDigitalGuideIdOrUrl: null,
  cover: null,
  branch: Branch.main,
);

const meta = Meta<DigitalGuideFeaturesSection>();

final $default = DigitalGuideFeaturesSectionStory(
  args: DigitalGuideFeaturesSectionArgs(
    digitalGuideData: Arg.fixed(_mockDigitalGuideData),
    building: Arg.fixed(_mockBuilding),
  ),
);
