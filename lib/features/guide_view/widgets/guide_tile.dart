import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../widgets/wide_tile_card.dart";
import "../../navigator/utils/navigation_commands.dart";
import "../repository/guide_repository.dart";

class GuideTile extends ConsumerWidget {
  const GuideTile(this.item, {super.key});
  final GuidePost item;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PhotoTrailingWideTileCard(
      context,
      title: item.name ?? "",
      subtitle: item.short_description,
      directusPhotoUrl: item.cover?.filename_disk,
      onTap: () async => ref.navigateGuideDetail(item.id),
      crossAxisAlignment: CrossAxisAlignment.stretch,
    );
  }
}
