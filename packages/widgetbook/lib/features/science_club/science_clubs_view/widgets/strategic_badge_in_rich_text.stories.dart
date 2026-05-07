import "package:flutter/material.dart";
import "package:topwr/features/science_club/science_clubs_view/widgets/strategic_badge.dart";
import "package:widgetbook/widgetbook.dart";

part "strategic_badge_in_rich_text.stories.g.dart";

class StrategicBadgeInRichTextStory extends StatelessWidget {
  const StrategicBadgeInRichTextStory({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text.rich(
      TextSpan(
        children: [
          TextSpan(text: "Club Name "),
          StrategicBadge(),
        ],
      ),
    );
  }
}

const meta = Meta<StrategicBadgeInRichTextStory>();

final $default = StrategicBadgeInRichTextStoryStory();
