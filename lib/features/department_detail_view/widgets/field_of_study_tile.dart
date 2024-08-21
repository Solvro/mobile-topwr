import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:separate/separate.dart";

import "../../../theme/app_theme.dart";
import "../../../theme/utils.dart";
import "../../../utils/launch_url_util.dart";
import "../../../widgets/wide_tile_card.dart";
import "fields_of_study_section.dart";

class FieldOfStudyTile extends ConsumerWidget {
  const FieldOfStudyTile(this.item, {super.key});
  final FieldOfStudy item;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const fontSize = 14.0;
    final emojiStyle = context.textTheme.headline.copyWith(fontSize: fontSize);
    return Theme(
      data: context.defaultThemeWithOverrideTextStyles(
        title: context.textTheme.lightTitle,
      ),
      child: WideTileCard(
        onTap: () async => ref.launch(item.url ?? ""),
        crossAxisAlignment: CrossAxisAlignment.center,
        title: item.name,
        trailing: Row(
          children: <Widget>[
            if (item.isEnglish ?? false)
              Text("🇬🇧", style: emojiStyle)
            else
              Text("🇵🇱", style: emojiStyle),
            Icon(
              Icons.sunny,
              color: context.colorTheme.greyPigeon,
              size: fontSize,
            ),
            if (item.hasWeekendModeOption ?? false)
              Icon(
                Icons.remove_red_eye_outlined,
                color: context.colorTheme.greyPigeon,
                size: fontSize,
              ),
            const SizedBox(width: 4),
          ].separate((i, e0, e1) => const SizedBox(width: 4)),
        ),
      ),
    );
  }
}
