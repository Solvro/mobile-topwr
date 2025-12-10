import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../api_base_rest/shared_models/image_data.dart";
import "../../../utils/context_extensions.dart";
import "../../../widgets/wide_tile_card.dart";
import "../../navigator/utils/navigation_commands.dart";

class AboutUsTile extends ConsumerWidget {
  const AboutUsTile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PhotoTrailingWideTileCard(
      context,
      title: context.localize.guide_about_us,
      subtitle: context.localize.guide_meet_creators,
      onTap: ref.navigateAboutUs,
      // Empty URL triggers MyCachedImage's fallback to show FlutterSplashScreen
      directusPhotoUrl: const ImageData(url: ""),
    );
  }
}
