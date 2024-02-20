import 'package:flutter/material.dart';

import '../../../../config.dart';
import '../../../../widgets/loading_widgets/wide_tile_loading.dart';

class BuildingsListLoading extends StatelessWidget {
  const BuildingsListLoading({super.key});

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
