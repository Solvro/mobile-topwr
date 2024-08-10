import "package:flutter/material.dart";
import "package:separate/separate.dart";

import "../../../theme/app_theme.dart";
import "../../../widgets/my_expansion_tile.dart";
import "../../../widgets/wide_tile_card.dart";
import "fields_of_study_section.dart";

class FieldOfStudyExpansionTile extends StatelessWidget {
  const FieldOfStudyExpansionTile({
    super.key,
    required this.fieldsOfStudy,
    required this.title,
    this.initiallyExpanded = false,
  });
  final Iterable<FieldOfStudy> fieldsOfStudy;
  final String title;
  final bool initiallyExpanded;
  @override
  Widget build(BuildContext context) {
    const fontSize = 18.0;
    final emojiStyle = context.textTheme.headline.copyWith(fontSize: 18);
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: MyExpansionTile(
        backgroundColor: context.colorTheme.whiteSoap,
        initiallyExpanded: initiallyExpanded,
        title: title,
        children: fieldsOfStudy
            .map<Widget>(
              (item) => WideTileCard(
                crossAxisAlignment: CrossAxisAlignment.center,
                title: item.name,
                trailing: Row(
                  children: <Widget>[
                    if (item.isEnglish)
                      Text("🇬🇧", style: emojiStyle)
                    else
                      Text("🇵🇱", style: emojiStyle),
                    Icon(
                      Icons.sunny,
                      color: context.colorTheme.greyPigeon,
                      size: fontSize,
                    ),
                    if (item.hasWeekendModeOption)
                      Icon(
                        Icons.remove_red_eye_outlined,
                        color: context.colorTheme.greyPigeon,
                        size: fontSize,
                      ),
                    const SizedBox.shrink(),
                  ].separate((i, e0, e1) => const SizedBox(width: 4)),
                ),
              ),
            )
            .separate((i, e0, e1) => const SizedBox(height: 12))
            .toList(),
      ),
    );
  }
}
