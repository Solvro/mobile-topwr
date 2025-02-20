import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../config/ui_config.dart";
import "../../../theme/app_theme.dart";
import "../../../utils/context_extensions.dart";
import "../../../widgets/my_expansion_tile.dart";
import "../../../widgets/my_html_widget.dart";
import "../../buildings_view/model/building_model.dart";
import "../data/models/digital_guide_object_model.dart";
import "../data/repositories/digital_guide_tabs_repository.dart";
import "digital_g_objs_amenietes_tab_tile_content.dart";

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
    final otherTiles = ref.watch(
      digitalGuideObjectTabsRepositoryProvider(digitalGuideData),
    );
    final items = <TileContent>[
      (
        title: context.localize.amenities,
        content: [
          DigitalGuideObjectsAmenietesTabTileContent(
          DigitalGuideObjectAmenietesTabTileContent(
          ),
        ],
      ),
      if (otherTiles.valueOrNull != null)
        for (final tile in otherTiles.valueOrNull!)
          (
            title: tile.translations.pl.name,
            content: [
              Padding(
                padding: const EdgeInsets.all(DigitalGuideConfig.paddingMedium),
                child: MyHtmlWidget(
                  tile.translations.pl.content,
                  textStyle: context.textTheme.boldBody,
                ),
              ),
            ],
          ),
    ];

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
