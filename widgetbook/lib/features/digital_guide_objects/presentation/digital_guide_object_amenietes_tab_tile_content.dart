import "package:flutter/widgets.dart";
import "package:topwr/features/digital_guide_objects/data/models/digital_guide_object_model.dart";
import "package:topwr/features/digital_guide_objects/presentation/digital_g_objects_amenietes_tab_tile_content.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

@widgetbook.UseCase(name: "default", type: DigitalGuideObjectAmenietesTabTileContent)
Widget useCaseDigitalGuideObjectAmenietesTabTileContent(BuildContext context) {
  const digitalGuideData = DigitalGuideObjectModel(
    id: 123,
    translations: DigitalGuideObjectTranslations(
      pl: DigitalGuideObjectTranslation(
        name: "Muzeum Przykładowe",
        address: "ul. Przykładowa 1, 00-000 Warszawa",
        accessibilityLevelForMotorDisabilityComment: "Brak barier architektonicznych.",
        accessibilityLevelForBlindComment: "Opis dla osób niewidomych.",
        accessibilityLevelForVisuallyImpairedComment: "Duże napisy na tablicach informacyjnych.",
        accessibilityLevelForHardOfHearingComment: "Brak pętli indukcyjnej.",
        accessibilityLevelForHighSensorySensitivityComment: "Stonowane oświetlenie.",
        accessibilityLevelForCognitiveDifficultiesComment: "Proste oznaczenia po trasie zwiedzania.",
      ),
    ),
    linkToObjectLocation: "https://maps.example.com/location",
    isPossibilityToEnterWithAssistanceDog: true,
    isMicronavigationSystem: true,
    areGuidancePaths: false,
    areInformationBoardsWithBrailleDescription: false,
    areInformationBoardsWithLargeFont: true,
    accessibilityLevelForMotorDisability: 5,
    accessibilityLevelForBlind: 4,
    accessibilityLevelForVisuallyImpaired: 3,
    accessibilityLevelForHardOfHearing: 2,
    accessibilityLevelForHighSensorySensitivity: 1,
    accessibilityLevelForCognitiveDifficulties: 5,
    images: [101, 102, 103],
  );

  return const DigitalGuideObjectAmenietesTabTileContent(digitalGuideData: digitalGuideData);
}
