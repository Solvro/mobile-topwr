import "package:flutter/widgets.dart";
import "package:topwr/features/digital_guide/presentation/widgets/accessibility_information_cards_list.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

@widgetbook.UseCase(name: "default", type: AccessibilityInformationCardsList)
Widget useCaseAccessibilityInformationCardsList(BuildContext context) {
  return AccessibilityInformationCardsList(
    prefix: "Building",
    accessibilityLevelType: (level) => "Level $level",
    accLevels: (
      accessibilityLevelForBlind: 0,
      accessibilityLevelForVisuallyImpaired: 2,
      accessibilityLevelForMotorDisability: 3,
      accessibilityLevelForCognitiveDifficulties: 1,
      accessibilityLevelForHardOfHearing: 0,
      accessibilityLevelForHighSensorySensitivity: 1,
    ),
    padding: const EdgeInsets.all(8),
  );
}
