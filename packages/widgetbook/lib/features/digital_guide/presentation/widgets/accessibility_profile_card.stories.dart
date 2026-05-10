import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/widgets.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:topwr/features/digital_guide/business/accessibility_comments_manager.dart";
import "package:topwr/features/digital_guide/presentation/widgets/accessibility_profile_card.dart";
import "package:topwr/features/digital_guide/tabs/accessibility_dialog/data/active_accessibility_modes_repository.dart";
import "package:topwr/features/digital_guide/tabs/accessibility_dialog/data/modes.dart";
import "package:widgetbook/widgetbook.dart";

part "accessibility_profile_card.stories.g.dart";

const meta = Meta<AccessibilityProfileCard>();

final class _SampleAccessibilityCommentsManager extends AccessibilityCommentsManager {
  @override
  IList<String> getCommentsListForBlind() => const IListConst(["High contrast signs on all floors"]);

  @override
  IList<String> getCommentsListForCognitiveImpairment() =>
      const IListConst(["Simple wayfinding with color-marked zones"]);

  @override
  IList<String> getCommentsListForHearingImpairment() => const IListConst(["Visual alerts available at main desk"]);

  @override
  IList<String> getCommentsListForLowVision() => const IListConst(["Large-font labels near elevators"]);

  @override
  IList<String> getCommentsListForMotorImpairment() => const IListConst(["Step-free route from main entrance"]);

  @override
  IList<String> getCommentsListForSensorySensitivity() => const IListConst(["Quiet room available on level 1"]);
}

final class _MockActiveAccessibilityModesRepository extends ActiveAccessibilityModesRepository {
  @override
  Future<ISet<ModeWithKey>> build() async => <ModeWithKey>{const Blind(), const MotorImpairment()}.toISet();
}

final $default = AccessibilityProfileCardStory(
  setup: (context, child, args) => ProviderScope(
    overrides: [activeAccessibilityModesRepositoryProvider.overrideWith(_MockActiveAccessibilityModesRepository.new)],
    child: child,
  ),
  args: AccessibilityProfileCardArgs(accessibilityCommentsManager: Arg.fixed(_SampleAccessibilityCommentsManager())),
);
