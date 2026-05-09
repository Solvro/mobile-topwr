import "package:topwr/features/digital_guide_objects/data/models/digital_guide_object_model.dart";
import "package:topwr/features/digital_guide_objects/presentation/digital_g_objects_amenietes_tab_tile_content.dart";
import "package:widgetbook/widgetbook.dart";
import "../../../widgetbook_mocks.dart";

part "digital_guide_object_amenietes_tab_tile_content.stories.g.dart";

const meta = Meta<DigitalGuideObjectAmenietesTabTileContent>();

final $default = DigitalGuideObjectAmenietesTabTileContentStory(
  args: DigitalGuideObjectAmenietesTabTileContentArgs(digitalGuideData: Arg.fixed(mockDigitalGuideObjectModel)),
);

const _mockDigitalGuideObjectWithAmenities = DigitalGuideObjectModel(
  id: 1,
  translations: DigitalGuideObjectTranslations(
    pl: DigitalGuideObjectTranslation(name: "C-13 Serowiec", address: "Wyb. Wyspianskiego 23-25, 50-370 Wroclaw"),
  ),
  isPossibilityToEnterWithAssistanceDog: true,
  isMicronavigationSystem: true,
  areGuidancePaths: true,
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

final $withAmenities = DigitalGuideObjectAmenietesTabTileContentStory(
  name: "With amenities",
  args: DigitalGuideObjectAmenietesTabTileContentArgs(
    digitalGuideData: Arg.fixed(_mockDigitalGuideObjectWithAmenities),
  ),
);
