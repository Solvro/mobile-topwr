import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../config.dart';
import '../../../../theme/app_theme.dart';
import '../../controllers/buildings_listview_controller.dart';
import '../buildings_list.dart';
import 'sheet_header.dart';
import 'sheet_sticky_header.dart';

class BottomScrollSheet<T> extends ConsumerWidget {
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
      //expand: true,
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
          child: SheetStickyHeader(
            scrollController: scrollController,
            header: const SheetHeader(),
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
