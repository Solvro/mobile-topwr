import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../theme/app_theme.dart";
import "../../../theme/utils.dart";
import "../../../utils/context_extensions.dart";
import "../../../widgets/wide_tile_card.dart";
import "../../navigator/utils/navigation_commands.dart";

class AboutUsTile extends ConsumerWidget {
  const AboutUsTile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Theme(
      data: context.defaultThemeWithOverrideTextStyles(
        title: context.textTheme.titleOrange,
      ),
      child: PhotoTrailingWideTileCard(
        title: context.localize.guide_about_us,
        subtitle: context.localize.guide_meet_creators,
        directusPhotoUrl: "",
        onTap: ref.navigateAboutUs,
      ),
    );
  }
}
