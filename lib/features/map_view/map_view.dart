import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../config.dart';
import '../../theme/app_theme.dart';
import '../buildings_map/controllers.dart';
import 'controllers/bottom_sheet_controller.dart';
import 'controllers/controllers.dart';
import 'widgets/bottom_scroll_sheet/bottom_scroll_sheet.dart';
import 'widgets/bottom_scroll_sheet/sheet_layout_scheme.dart';
import 'widgets/map_widget.dart';

class BuildingMapView extends ConsumerWidget {
  const BuildingMapView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ProviderScope(overrides: [
      mapControllersProvider.overrideWith((ref) => mapControllersBuildings),
      bottomSheetControllerProvider,
      bottomSheetPixelsProvider,
    ], child: const MapView());
  }
}

class ParkingsMapView extends ConsumerWidget {
  const ParkingsMapView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ProviderScope(overrides: [
      mapControllersProvider.overrideWith((ref) => mapControllersBuildings),
      bottomSheetControllerProvider,
      bottomSheetPixelsProvider,
    ], child: const MapView());
  }
}

class MapView extends ConsumerWidget {
  const MapView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isBigScreen = MediaQuery.sizeOf(context).width >
        MapViewBottomSheetConfig.horizontalPanelModeMinWidth;
    return Scaffold(
      backgroundColor: context.colorTheme.whiteSoap,
      body: kIsWeb || isBigScreen
          ? const HorizontalWebLayout()
          : const Stack(children: [
              MapWidget(),
              BottomScrollSheet(),
            ]),
    );
  }
}

class HorizontalWebLayout extends StatelessWidget {
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
          child: const SheetLayoutScheme(),
        ),
        const Expanded(child: MapWidget())
      ],
    );
  }
}
