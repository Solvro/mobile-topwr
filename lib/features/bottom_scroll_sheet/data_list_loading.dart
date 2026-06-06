import "package:flutter/material.dart";

import "../../config/map_view_config.dart";
import "../../widgets/loading_widgets/specific_imitations/wide_tile_loading.dart";

class DataSliverListLoading extends StatelessWidget {
  const DataSliverListLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
      itemBuilder: (context, index) {
        return const Padding(
          padding: EdgeInsets.only(
            left: MapViewBottomSheetConfig.horizontalPadding,
            right: MapViewBottomSheetConfig.horizontalPadding,
            bottom: 16,
          ),
          child: WideTileLoading(),
        );
      },
    );
  }
}
