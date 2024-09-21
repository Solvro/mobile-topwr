import "dart:math";

import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../config/map_view_config.dart";
import "../../theme/app_theme.dart";
import "../bottom_scroll_sheet/bottom_scroll_sheet.dart";
import "../bottom_scroll_sheet/sheet_layout_scheme.dart";
import "controllers/bottom_sheet_controller.dart";
import "controllers/controllers_set.dart";
import "widgets/map_config.dart";
import "widgets/map_widget.dart";

class MapView<T extends GoogleNavigable> extends ConsumerWidget {
  const MapView({
    required this.mapViewTexts,
    required this.mapControllers,
    required this.markerBuilder,
    required this.mapTileBuilder,
    required this.mapSheetSize,
    this.animateListTiles = false,
    this.initialActiveItemId,
    super.key,
  });
  final MapControllers<T> mapControllers;
  final MarkerBuilder<T> markerBuilder;
  final MapTileBuilder<T> mapTileBuilder;
  final MapViewTexts mapViewTexts;
  final MapSheetSize mapSheetSize;
  final bool animateListTiles;
  final String? initialActiveItemId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isBigScreen = MediaQuery.sizeOf(context).width >
        MapViewBottomSheetConfig.horizontalPanelModeMinWidth;
    return ProviderScope(
      overrides: [
        bottomSheetControllerProvider,
        bottomSheetPixelsProvider,
        mapControllers.map,
        mapControllers.activeMarker,
      ],
      child: MapConfig(
        controllers: mapControllers,
        markerBuilder: markerBuilder,
        mapTileBuilder: mapTileBuilder,
        mapViewTexts: mapViewTexts,
        mapSheetSize: mapSheetSize,
        animateListTiles: animateListTiles,
        initialActiveItemId: initialActiveItemId,
        child: Scaffold(
          backgroundColor: context.colorTheme.whiteSoap,
          body: kIsWeb || isBigScreen
              ? _HorizontalWebLayout<T>()
              : Stack(
                  children: [
                    MapWidget<T>(),
                    BottomScrollSheet<T>(),
                  ],
                ),
        ),
      ),
    );
  }
}

class _HorizontalWebLayout<T extends GoogleNavigable> extends StatelessWidget {
  const _HorizontalWebLayout({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final double panelWidth = min(350, MediaQuery.sizeOf(context).width);
    return Row(
      children: [
        SizedBox(
          width: panelWidth,
          child: SheetLayoutScheme<T>(),
        ),
        Expanded(child: MapWidget<T>()),
      ],
    );
  }
}
