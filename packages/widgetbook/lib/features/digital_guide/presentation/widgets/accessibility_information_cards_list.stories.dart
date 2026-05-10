import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:topwr/features/digital_guide/presentation/widgets/accessibility_information_cards_list.dart";
import "package:topwr/features/digital_guide/tabs/accessibility_dialog/data/active_accessibility_modes_repository.dart";
import "package:topwr/features/digital_guide/tabs/accessibility_dialog/data/modes.dart";
import "package:widgetbook/widgetbook.dart";

part "accessibility_information_cards_list.stories.g.dart";

const meta = Meta<AccessibilityInformationCardsList>();

final class _MockActiveAccessibilityModesRepository extends ActiveAccessibilityModesRepository {
  @override
  Future<ISet<ModeWithKey>> build() async =>
      <ModeWithKey>{const Blind(), const LowVision(), const HearingImpairment()}.toISet();
}

final $default = AccessibilityInformationCardsListStory(
  setup: (context, child, args) => ProviderScope(
    overrides: [activeAccessibilityModesRepositoryProvider.overrideWith(_MockActiveAccessibilityModesRepository.new)],
    child: child,
  ),
  args: AccessibilityInformationCardsListArgs(
    prefix: Arg.fixed("Building"),
    accessibilityLevelType: Arg.fixed((label) => label),
    accLevels: Arg.fixed((
      accessibilityLevelForBlind: 1,
      accessibilityLevelForCognitiveDifficulties: 2,
      accessibilityLevelForHardOfHearing: 3,
      accessibilityLevelForHighSensorySensitivity: 4,
      accessibilityLevelForMotorDisability: 2,
      accessibilityLevelForVisuallyImpaired: 3,
    )),
  ),
);
