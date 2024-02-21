import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';
import 'widgets/bottom_scroll_sheet/bottom_scroll_sheet.dart';
import 'widgets/bottom_scroll_sheet/sheet_layout_scheme.dart';
import 'widgets/map_widget.dart';

class MapView extends StatelessWidget {
  const MapView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorTheme.whiteSoap,
      body: kIsWeb
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
