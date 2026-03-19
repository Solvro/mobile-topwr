import "package:flutter/widgets.dart";
import "package:topwr/features/digital_guide_objects/data/models/digital_guide_object_model.dart";
import "package:topwr/features/digital_guide_objects/presentation/digital_g_objects_featers_list.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

@widgetbook.UseCase(name: "default", type: DigitalGuideObjectsFeaturesSection)
Widget useCaseDigitalGuideObjectsFeaturesSection(BuildContext context) {
  const digitalGuideData = DigitalGuideObjectModel(
    id: 456,
    translations: DigitalGuideObjectTranslations(
      pl: DigitalGuideObjectTranslation(
        name: "Galeria Sztuki Nowoczesnej",
        address: "al. Example 2, 11-111 Kraków",
        accessibilityLevelForMotorDisabilityComment: "Windy dostępne na wszystkich piętrach.",
        accessibilityLevelForBlindComment: "Napisy Braille na poręczach.",
        accessibilityLevelForVisuallyImpairedComment: "Wysoki kontrast na oznaczeniach.",
        accessibilityLevelForHardOfHearingComment: "Tablice tekstowe przy wszystkich ekspozycjach.",
        accessibilityLevelForHighSensorySensitivityComment: "Strefy ciszy dostępne.",
        accessibilityLevelForCognitiveDifficultiesComment: "Opiekun dostępny przez cały czas zwiedzania.",
      ),
    ),
    linkToObjectLocation: "https://maps.example.com/other-location",
    isPossibilityToEnterWithAssistanceDog: false,
    isMicronavigationSystem: false,
    areGuidancePaths: true,
    areInformationBoardsWithBrailleDescription: true,
    areInformationBoardsWithLargeFont: true,
    accessibilityLevelForMotorDisability: 4,
    accessibilityLevelForBlind: 5,
    accessibilityLevelForVisuallyImpaired: 5,
    accessibilityLevelForHardOfHearing: 3,
    accessibilityLevelForHighSensorySensitivity: 2,
    accessibilityLevelForCognitiveDifficulties: 4,
    locationMap: "https://example.com/map.png",
    images: [201, 202],
  );

  return const DigitalGuideObjectsFeaturesSection(digitalGuideData: digitalGuideData);
}
