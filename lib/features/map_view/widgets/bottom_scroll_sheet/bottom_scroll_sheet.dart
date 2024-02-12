import 'package:flutter/material.dart';

import '../../../../config.dart';
import '../../../../theme/app_theme.dart';
import '../building_list_view.dart';
import 'bottom_sheet_header.dart';

typedef ItemFromListBuilder<T> = Widget Function(
    BuildContext context, T element, int index);

class BottomScrollSheet<T> extends StatelessWidget {
  const BottomScrollSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final sheetController = DraggableScrollableController();
    return DraggableScrollableSheet(
      controller: sheetController,
      initialChildSize: 0.4,
      maxChildSize: 1,
      minChildSize: 0.2,
      expand: true,
      snap: true,
      snapSizes: const [0.5, 0.75],
      builder: (BuildContext context, ScrollController scrollController) {
        return DecoratedBox(
          decoration:
              _RoundedTopDecoration(color: context.colorTheme.whiteSoap),
          child: Column(
            children: [
              const BottomSheetHeader(),
              Expanded(
                child: BuildingsListView(scrollController, sheetController),
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
