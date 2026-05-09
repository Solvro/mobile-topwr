import "package:flutter/material.dart";
import "package:topwr/features/science_club/science_clubs_view/widgets/verified_badge.dart";
import "package:widgetbook/widgetbook.dart";

part "verified_badge_in_rich_text.stories.g.dart";

/// Host widget: [VerifiedBadge] is a [WidgetSpan], shown here inside [Text.rich] like in the app.
class VerifiedBadgeInRichTextStory extends StatelessWidget {
  const VerifiedBadgeInRichTextStory({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text.rich(
      TextSpan(
        children: [
          TextSpan(text: "Club Name "),
          VerifiedBadge(),
        ],
      ),
    );
  }
}

const meta = Meta<VerifiedBadgeInRichTextStory>();

final $default = VerifiedBadgeInRichTextStoryStory();
