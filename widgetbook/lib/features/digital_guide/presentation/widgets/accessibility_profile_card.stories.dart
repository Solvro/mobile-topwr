import "package:flutter/widgets.dart";
import "package:topwr/features/digital_guide/business/accessibility_comments_manager.dart";
import "package:topwr/features/digital_guide/presentation/widgets/accessibility_profile_card.dart";
import "package:widgetbook/widgetbook.dart";

import "../../../../widgetbook_mocks.dart";

part "accessibility_profile_card.stories.g.dart";

const meta = Meta<AccessibilityProfileCard>();

final $default = AccessibilityProfileCardStory(
  args: AccessibilityProfileCardArgs(accessibilityCommentsManager: Arg.fixed(EmptyAccessibilityCommentsManager())),
);
