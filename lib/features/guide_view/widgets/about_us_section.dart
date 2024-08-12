import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../theme/app_theme.dart";
import "../../../utils/context_extensions.dart";
import "../../../widgets/wide_tile_card.dart";
import "../../navigator/utils/navigation_commands.dart";

class GuideAboutUsSection extends ConsumerWidget {
  const GuideAboutUsSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Theme(
      data: Theme.of(context).getAlTitlesOrange(context),
      child: PhotoTrailingWideTileCard(
        title: context.localize.guide_about_us,
        subtitle: context.localize.guide_meet_creators,
        photoUrl: "",
        onTap: ref.navigateAboutUs,
      ),
    );
  }
}

extension _ChangeTitleToOrangeTitleX on ThemeData {
  ThemeData getAlTitlesOrange(BuildContext context) => copyWith(
        extensions: [
          context.appTheme.copyWith(
            textTheme: context.textTheme.copyWith(
              title: context.textTheme.titleOrange,
            ),
          ),
        ],
      );
}
