import "dart:math";

import "package:flutter/material.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";

import "../../config/map_view_config.dart";
import "../../hooks/use_semantics_service_on_changed_value.dart";
import "../../theme/app_theme.dart";
import "../../utils/context_extensions.dart";
import "../map_view/controllers/bottom_sheet_controller.dart";
import "../map_view/controllers/controllers_set.dart";
import "../map_view/widgets/map_config.dart";
import "map_view_pop_behaviour.dart";
import "map_data_sheet_list.dart";

class BottomScrollSheet<T extends GoogleNavigable> extends ConsumerWidget {
  const BottomScrollSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final scaler = context.textScaler.clamp(maxScaleFactor: 1.5);
        final screenHeight = constraints.maxHeight;
        final sheetSize = context.mapSheetSize<T>();

        final isAnyActive = ref.watch(context.activeMarkerController<T>()) != null;
        final recommendedSheetHeight = scaler.scale(
          isAnyActive ? sheetSize.recomendedActiveSheetHeight : sheetSize.recomendedSheetHeight,
        );
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
              return _SheetConsumer<T>(
                recommendedSheetHeight: recommendedSheetHeight,
                scrollController: scrollController,
              );
            },
          ),
        );
      },
    );
  }
}

class _SheetConsumer<T extends GoogleNavigable> extends HookConsumerWidget {
  const _SheetConsumer({required this.recommendedSheetHeight, required this.scrollController});

  final double recommendedSheetHeight;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = ref.watch(bottomSheetPixelsProvider);
    final isExpanded = size > recommendedSheetHeight;

    final l10n = context.localize;
    useSemanticsServiceOnChangedValue(
      isExpanded,
      messageBuilder: (expanded) => expanded ? l10n.expanded_screen_reader_label : l10n.collapsed_screen_reader_label,
    );

    return Semantics(
      label: isExpanded
          ? context.localize.bottom_scroll_sheet_description_expanded
          : context.localize.bottom_scroll_sheet_description_collapsed,
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: _RoundedTopDecoration(color: context.colorTheme.whiteSoap),
        child: MapDataSheetList<T>(scrollController: scrollController),
      ),
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
