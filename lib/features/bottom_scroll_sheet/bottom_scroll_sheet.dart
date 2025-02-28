import "dart:math";

import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../config/map_view_config.dart";
import "../../theme/app_theme.dart";
import "../map_view/controllers/bottom_sheet_controller.dart";
import "../map_view/controllers/controllers_set.dart";
import "../map_view/widgets/map_config.dart";
import "map_view_pop_behaviour.dart";
import "sheet_layout_scheme.dart";

class BottomScrollSheet<T extends GoogleNavigable> extends ConsumerWidget {
  const BottomScrollSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenHeight = constraints.maxHeight;
        final sheetSize = context.mapSheetSize<T>();

        final isAnyActive = ref.watch(context.activeMarkerController<T>()) != null;
        final recommendedSheetHeight =
            isAnyActive ? sheetSize.recomendedActiveSheetHeight : sheetSize.recomendedSheetHeight;

        final minSheetHeight = sheetSize.minSheetHeight;

        final double recommendedSheetFraction = min(1, recommendedSheetHeight / screenHeight);
        final minSheetFraction = min(0.25, minSheetHeight / screenHeight);

        return MapViewPopBehaviour<T>(
          screenHeight: screenHeight,
          child: DraggableScrollableSheet(
            controller: ref.watch(bottomSheetControllerProvider),
            initialChildSize: recommendedSheetFraction,
            minChildSize: minSheetFraction,
            snap: true,
            snapSizes: [recommendedSheetFraction],
            builder: (BuildContext context, ScrollController scrollController) {
              return Container(
                clipBehavior: Clip.antiAlias,
                decoration: _RoundedTopDecoration(color: context.colorTheme.whiteSoap),
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
