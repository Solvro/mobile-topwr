import 'package:flutter/material.dart';

import '../../../../config.dart';
import '../../../../widgets/loading_widgets/specific_imitations/wide_tile_loading.dart';

class DataListLoading extends StatelessWidget {
  const DataListLoading({super.key});

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
