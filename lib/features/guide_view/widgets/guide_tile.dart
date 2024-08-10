import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../api_base/directus_assets_url.dart";
import "../../../config/ui_config.dart";
import "../../../widgets/wide_tile_card.dart";
import "../../navigator/utils/navigation_commands.dart";
import "../repository/guide_repository.dart";

class GuideTile extends ConsumerWidget {
  const GuideTile(this.item, {super.key});
  final GuidePost item;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: GuideViewConfig.tilePadding,
      child: PhotoTrailingWideTileCard(
        title: item.name ?? "",
        subtitle: item.short_description,
        photoUrl: item.cover?.filename_disk?.directusUrl ?? "",
        onTap: () async => ref.navigateGuideDetail(item.id),
      ),
    );
  }
}
