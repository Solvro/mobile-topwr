import "package:flutter/widgets.dart";
import "package:topwr/features/building_detail_view/presentation/widgets/expansion_tiles/building_localization_expansion_tile.dart";


class BuildingFeaturesSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 24, right: 24, top: 24, bottom: 8),
      child: Column(
        children: [
          BuildingExpansionTile(title: "Localization")
        ],
      )
    );
  }
}