import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/widgets.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:topwr/features/digital_guide/data/models/digital_guide_response.dart";
import "package:topwr/features/digital_guide/tabs/lodge/data/repository/lodges_repository.dart";
import "package:topwr/features/digital_guide/tabs/lodge/presentation/digital_guide_lodge_expansion_tile_content.dart";
import "package:widgetbook/widgetbook.dart";

part "digital_guide_lodge_expansion_tile_content.stories.g.dart";

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

const meta = Meta<DigitalGuideLodgeExpansionTileContent>();

final $default = DigitalGuideLodgeExpansionTileContentStory(
  setup: (context, child, args) => ProviderScope(
    key: ValueKey("lodge-${args.digitalGuideResponse.id}"),
    overrides: [lodgesRepositoryProvider.overrideWith((ref, response) async => IListConst(const []))],
    child: child,
  ),
  args: DigitalGuideLodgeExpansionTileContentArgs(digitalGuideResponse: Arg.fixed(_mockDigitalGuideData)),
);
