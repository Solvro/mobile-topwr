import 'package:flutter/material.dart';

import '../../../../config.dart';
import '../../../../theme/app_theme.dart';
import 'bottom_sheet_header.dart';

class BottomScrollSheet extends StatelessWidget {
  const BottomScrollSheet({
    super.key,
    required this.children,
  });
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      // key: _sheet,
      initialChildSize: 0.2,
      maxChildSize: 1,
      minChildSize: 0.2,
      expand: true,
      snap: true,
      snapSizes: const [0.5, 0.75],
      // /controller: _controller,
      builder: (BuildContext context, ScrollController scrollController) {
        return DecoratedBox(
          decoration:
              _RoundedTopDecoration(color: context.colorTheme.whiteSoap),
          child: Column(
            children: [
              const BottomSheetHeader(),
              Expanded(
                child: ListView(
                  controller: scrollController,
                  children: children,
                ),
              ),
            ],
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
            topLeft: MapViewConfig.bottomSheetRadius,
            topRight: MapViewConfig.bottomSheetRadius,
          ),
        );
}
