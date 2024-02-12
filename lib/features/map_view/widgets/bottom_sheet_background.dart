import 'package:flutter/material.dart';

import '../../../config.dart';
import '../../../theme/app_theme.dart';

class BottomSheetBackground extends StatelessWidget {
  const BottomSheetBackground({
    required this.header,
    required this.scrollableChild,
    super.key,
  });
  final Widget header;
  final ScrollView scrollableChild;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: context.colorTheme.whiteSoap,
        borderRadius: const BorderRadius.only(
          topLeft: MapViewConfig.bottomSheetRadius,
          topRight: MapViewConfig.bottomSheetRadius,
        ),
      ),
      child: Column(
        children: [
          header,
          Expanded(
            child: scrollableChild,
          ),
        ],
      ),
    );
  }
}
