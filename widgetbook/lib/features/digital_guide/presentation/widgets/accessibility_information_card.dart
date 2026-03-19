import "package:flutter/material.dart";
import "package:topwr/features/digital_guide/presentation/widgets/accessibility_information_card.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

@widgetbook.UseCase(name: "default", type: AccessibilityInformationCard)
Widget useCaseAccessibilityInformationCard(BuildContext context) {
  return const AccessibilityInformationCard(
    color: Color(0xFFB1261E), // red
    icon: "assets/svg/digital_guide/accessibility_alerts/blind_profile.svg",
    text: "Sample text",
  );
}
