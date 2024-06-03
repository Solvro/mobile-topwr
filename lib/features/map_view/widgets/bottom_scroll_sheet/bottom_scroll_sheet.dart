import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../config.dart';
import '../../../../theme/app_theme.dart';
import '../../controllers/bottom_sheet_controller.dart';
import '../../controllers/controllers_set.dart';
import '../map_config.dart';
import 'map_view_pop_behaviour.dart';
import 'sheet_layout_scheme.dart';

class BottomScrollSheet<T extends GoogleNavigable> extends ConsumerWidget {
  const BottomScrollSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenHeight = constraints.maxHeight;
        final sheetSize = context.mapSheetSize<T>();

        final isAnyActive =
            ref.watch(context.activeMarkerController<T>()) != null;
        final recomendedSheetHeight = isAnyActive
            ? sheetSize.recomendedActiveSheetHeight
            : sheetSize.recomendedSheetHeight;

        final minSheetHeight = sheetSize.minSheetHeight;

        final recomendedSheetFraction =
            min(1.0, recomendedSheetHeight / screenHeight);
        final minSheetFraction = min(0.25, minSheetHeight / screenHeight);

        return MapViewPopBehaviour<T>(
          screenHeight: screenHeight,
          child: DraggableScrollableSheet(
            controller: ref.watch(bottomSheetControllerProvider),
            initialChildSize: recomendedSheetFraction,
            maxChildSize: 1, // factor 1 means 100% available height
            minChildSize: minSheetFraction,
            snap: true,
            snapSizes: [recomendedSheetFraction],
            builder: (BuildContext context, ScrollController scrollController) {
              return Container(
                clipBehavior: Clip.antiAlias,
                decoration:
                    _RoundedTopDecoration(color: context.colorTheme.whiteSoap),
                child: SheetLayoutScheme<T>(scrollController: scrollController),
              );
            },
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
