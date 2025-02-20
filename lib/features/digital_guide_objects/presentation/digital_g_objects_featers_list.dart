import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../widgets/my_expansion_tile.dart";
import "../../buildings_view/model/building_model.dart";
import "../data/digital_guide_object_model.dart";

typedef TileContent = ({String title, List<Widget> content});

class DigitalGObjectsFeaturesSection extends ConsumerWidget {
  const DigitalGObjectsFeaturesSection({
    required this.digitalGuideData,
    required this.building,
  });

  final DigitalGuideObjectModel digitalGuideData;
  final BuildingModel building;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = <TileContent>[];

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final item = items[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            padding: const EdgeInsets.symmetric(
              horizontal: DigitalGuideConfig.paddingBig,
              vertical: DigitalGuideConfig.heightSmall,
            ),
              title: item.title,
              children: item.content,
            ),
          );
        },
        childCount: items.length,
      ),
    );
  }
}
