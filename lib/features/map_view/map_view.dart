import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../config.dart';
import '../../theme/app_theme.dart';
import 'controllers/controllers_set.dart';
import 'widgets/bottom_scroll_sheet/bottom_scroll_sheet.dart';
import 'widgets/bottom_scroll_sheet/sheet_layout_scheme.dart';
import 'widgets/map_config.dart';
import 'widgets/map_widget.dart';

class GeneralMapView<T> extends ConsumerWidget {
  const GeneralMapView({
    required this.mapControllers,
    required this.markerBuilder,
    super.key,
  });
  final MapControllers<T> mapControllers;
  final MarkerBuilder<T> markerBuilder;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isBigScreen = MediaQuery.sizeOf(context).width >
        MapViewBottomSheetConfig.horizontalPanelModeMinWidth;
    return MapConfig(
      controllers: mapControllers,
      markerBuilder: markerBuilder,
      child: Scaffold(
        backgroundColor: context.colorTheme.whiteSoap,
        body: kIsWeb || isBigScreen
            ? const HorizontalWebLayout()
            : const Stack(children: [
                MapWidget(),
                BottomScrollSheet(),
              ]),
      ),
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
