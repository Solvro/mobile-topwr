import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../../../../config/ui_config.dart";
import "../../../../presentation/widgets/digital_guide_nav_link.dart";
import "region_data_sliver_list_item.dart";

class RegionDataSliverList extends ConsumerWidget {
  const RegionDataSliverList({
    required this.regionDataSliverListItem,
  });

  final RegionDataSliverListItem regionDataSliverListItem;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) => Column(
          children: [
            DigitalGuideNavLink(
              onTap: () async => regionDataSliverListItem.onTap?.call(index),
              text: regionDataSliverListItem.text(index),
            ),
            const SizedBox(
              height: DigitalGuideConfig.heightMedium,
            ),
          ],
        ),
        childCount: regionDataSliverListItem.itemCount,
      ),
    );
  }
}
