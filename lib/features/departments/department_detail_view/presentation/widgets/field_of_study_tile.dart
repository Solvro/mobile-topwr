import "dart:async";

import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:separate/separate.dart";

import "../../../../../theme/app_theme.dart";
import "../../../../../utils/launch_url_util.dart";
import "../../../../../widgets/wide_tile_card.dart";
import "../../../../analytics/data/clarity.dart";
import "../../../../analytics/data/clarity_events.dart";
import "../../data/models/department_details.dart";

class FieldOfStudyTile extends ConsumerWidget {
  const FieldOfStudyTile(this.item, {super.key});
  final FieldOfStudy item;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const fontSize = 14.0;
    final emojiStyle = context.textTheme.headlineMedium?.copyWith(fontSize: fontSize);
    return Theme(
      data: context.defaultThemeWithOverrideTextStyles(titleLarge: context.textTheme.titleMedium),
      child: WideTileCard(
        onTap: () async {
          unawaited(ref.trackEvent(ClarityEvents.openFieldOfStudiesLink, value: item.url));
          await ref.launch(item.url);
        },
        crossAxisAlignment: CrossAxisAlignment.center,
        title: item.name,
        fixedTrailingHeight: false,
        trailing: Row(
          children: <Widget>[
            if (item.isEnglish) Text("🇬🇧", style: emojiStyle) else Text("🇵🇱", style: emojiStyle),
            Icon(Icons.sunny, color: context.colorScheme.tertiary, size: fontSize),
            if (item.hasWeekendOption)
              Icon(Icons.remove_red_eye_outlined, color: context.colorScheme.tertiary, size: fontSize),
            const SizedBox(width: 4),
          ].separate((i, e0, e1) => const SizedBox(width: 4)),
        ),
      ),
    );
  }
}
