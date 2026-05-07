import "package:flutter/material.dart";
import "package:topwr/features/digital_guide/presentation/widgets/accessibility_information_cards_list.dart";
import "package:widgetbook/widgetbook.dart";

part "accessibility_information_cards_list.stories.g.dart";

const meta = Meta<AccessibilityInformationCardsList>();

final $default = AccessibilityInformationCardsListStory(
  args: AccessibilityInformationCardsListArgs(
    accessibilityLevelType: Arg.fixed((label) => label),
    accLevels: Arg.fixed((
      accessibilityLevelForBlind: 1,
      accessibilityLevelForCognitiveDifficulties: 2,
      accessibilityLevelForHardOfHearing: 3,
      accessibilityLevelForHighSensorySensitivity: 4,
      accessibilityLevelForMotorDisability: 5,
      accessibilityLevelForVisuallyImpaired: 6,
    )),
  ),
);
