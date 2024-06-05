import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../config/map_view_config.dart';
import '../../theme/app_theme.dart';
import 'controllers/bottom_sheet_controller.dart';
import 'controllers/controllers_set.dart';
import 'widgets/bottom_scroll_sheet/bottom_scroll_sheet.dart';
import 'widgets/bottom_scroll_sheet/sheet_layout_scheme.dart';
import 'widgets/map_config.dart';
import 'widgets/map_widget.dart';

class GeneralMapView<T extends GoogleNavigable> extends ConsumerWidget {
  const GeneralMapView({
    required this.mapViewTexts,
    required this.mapControllers,
    required this.markerBuilder,
    required this.mapTileBuilder,
    required this.mapSheetSize,
    super.key,
  });
  final MapControllers<T> mapControllers;
  final MarkerBuilder<T> markerBuilder;
  final MapTileBuilder<T> mapTileBuilder;
  final MapViewTexts mapViewTexts;
  final MapSheetSize mapSheetSize;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isBigScreen = MediaQuery.sizeOf(context).width >
        MapViewBottomSheetConfig.horizontalPanelModeMinWidth;
    return ProviderScope(
      overrides: [
        bottomSheetControllerProvider,
        bottomSheetPixelsProvider,
        mapControllers.map,
      ],
      child: MapConfig(
        controllers: mapControllers,
        markerBuilder: markerBuilder,
        mapTileBuilder: mapTileBuilder,
        mapViewTexts: mapViewTexts,
        mapSheetSize: mapSheetSize,
        child: Scaffold(
          backgroundColor: context.colorTheme.whiteSoap,
          body: kIsWeb || isBigScreen
              ? HorizontalWebLayout<T>()
              : Stack(children: [
                  MapWidget<T>(),
                  BottomScrollSheet<T>(),
                ]),
        ),
      ),
    );
  }
}

class HorizontalWebLayout<T extends GoogleNavigable> extends StatelessWidget {
  const HorizontalWebLayout({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final panelWidth = min(350.0, MediaQuery.sizeOf(context).width);
    return Row(
      children: [
        SizedBox(
          width: panelWidth,
          child: SheetLayoutScheme<T>(),
        ),
        Expanded(child: MapWidget<T>())
      ],
    );
  }
}
