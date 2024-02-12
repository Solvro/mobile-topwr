import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';
import 'widgets/bottom_scroll_sheet.dart';

class MapView extends StatelessWidget {
  const MapView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorTheme.whiteSoap,
      body: const Stack(children: [
        Placeholder(color: Colors.red),
        BottomScrollSheet(),
      ]),
    );
  }
}
