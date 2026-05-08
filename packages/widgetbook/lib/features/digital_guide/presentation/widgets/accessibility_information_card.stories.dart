import "package:flutter/material.dart";
import "package:topwr/features/digital_guide/presentation/widgets/accessibility_information_card.dart";
import "package:topwr_assets/gen/assets.gen.dart";
import "package:widgetbook/widgetbook.dart";

part "accessibility_information_card.stories.g.dart";

const meta = Meta<AccessibilityInformationCard>();

final $default = AccessibilityInformationCardStory(
  args: AccessibilityInformationCardArgs.fixed(
    color: Colors.orange,
    icon: Assets.svg.digitalGuide.accessibilityAlerts.blindProfile,
    text: "Informacja o dostępności budynku",
  ),
);
