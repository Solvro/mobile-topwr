import "package:flutter/widgets.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:topwr/features/digital_guide/tabs/accessibility_dialog/business/accessibility_mode_service.dart";
import "package:topwr/features/digital_guide/tabs/accessibility_dialog/data/accessibility_mode_repository.dart";
import "package:topwr/features/digital_guide/tabs/accessibility_dialog/data/modes.dart";
import "package:topwr/features/digital_guide/tabs/accessibility_dialog/presentation/mode_checkbox.dart";
import "package:widgetbook/widgetbook.dart";

part "mode_checkbox.stories.g.dart";

const meta = Meta<ModeCheckbox>();

final class _MockAccessibilityModeService extends AccessibilityModeService {
  @override
  Future<bool> build(AccessibilityMode mode) async => true;
}

final class _MockAccessibilityModeRepository extends AccessibilityModeRepository {
  @override
  Future<bool> build(ModeWithKey mode) async => true;

  @override
  Future<void> setMode({required bool newValue}) async {}
}

final $default = ModeCheckboxStory(
  setup: (context, child, args) => ProviderScope(
    overrides: [
      accessibilityModeServiceProvider(args.mode).overrideWith(_MockAccessibilityModeService.new),
      accessibilityModeRepositoryProvider(const Blind()).overrideWith(_MockAccessibilityModeRepository.new),
    ],
    child: child,
  ),
  args: ModeCheckboxArgs(mode: Arg.fixed(const Blind())),
);
