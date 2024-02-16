import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../config.dart';
import '../../../../theme/app_theme.dart';
import '../../controllers/buildings_listview_controller.dart';
import '../buildings_list.dart';
import 'custom_sheet_scroll_view.dart';

class BottomScrollSheet extends ConsumerWidget {
  const BottomScrollSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenHeight = MediaQuery.sizeOf(context).height;
    final recomendedSheetFraction =
        MapViewBottomSheetConfig.recomendedSheetHeight / screenHeight;
    final minSheetFraction =
        MapViewBottomSheetConfig.minSheetHeight / screenHeight;

    return DraggableScrollableSheet(
      controller: ref.watch(bottomSheetControllerProvider),
      initialChildSize: recomendedSheetFraction,
      maxChildSize: 1, // factor 1 means 100% available height
      minChildSize: minSheetFraction,
      snap: true,
      snapSizes: [
        if (recomendedSheetFraction >
            MapViewBottomSheetConfig.extraSnapPointFraction1)
          MapViewBottomSheetConfig.extraSnapPointFraction1,
        MapViewBottomSheetConfig.extraSnapPointFraction2,
      ],
      builder: (BuildContext context, ScrollController scrollController) {
        return Container(
          clipBehavior: Clip.antiAlias,
          decoration:
              _RoundedTopDecoration(color: context.colorTheme.whiteSoap),
          child: CustomSheetScrollView(
            scrollController: scrollController,
            body: const BuildingsList(),
          ),
        );
      },
    );
  }
}

class _RoundedTopDecoration extends BoxDecoration {
  const _RoundedTopDecoration({super.color})
      : super(
          borderRadius: const BorderRadius.only(
            topLeft: MapViewBottomSheetConfig.bottomSheetRadius,
            topRight: MapViewBottomSheetConfig.bottomSheetRadius,
          ),
        );
}
