import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../config.dart';
import '../../../../theme/app_theme.dart';
import '../../controllers/bottom_sheet_controller.dart';
import 'sheet_layout_scheme.dart';

class BottomScrollSheet extends ConsumerWidget {
  const BottomScrollSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenHeight = constraints.maxHeight;

        final recomendedSheetFraction = min(
            1.0, MapViewBottomSheetConfig.recomendedSheetHeight / screenHeight);
        final minSheetFraction =
            min(0.25, MapViewBottomSheetConfig.minSheetHeight / screenHeight);

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
              child: SheetLayoutScheme(scrollController: scrollController),
            );
          },
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
