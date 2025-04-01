import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../widgets/wide_tile_card.dart";
import "../../navigator/utils/navigation_commands.dart";
import "../models/guide_data.dart";

class GuideTile extends ConsumerWidget {
  const GuideTile(this.item, {super.key});
  final GuideData item;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PhotoTrailingWideTileCard(
      title: item.title,
      subtitle: item.shortDesc,
      directusPhotoUrl: item.imagePath,
      onTap: () async => ref.navigateGuideDetail(item.id),
    );
  }
}
