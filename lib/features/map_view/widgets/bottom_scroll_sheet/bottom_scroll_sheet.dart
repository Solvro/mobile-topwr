import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../config.dart';
import '../../../../theme/app_theme.dart';
import '../../controllers/map_view_controller.dart';
import '../building_list_view.dart';
import 'bottom_sheet_header.dart';

typedef ItemFromListBuilder<T> = Widget Function(
    BuildContext context, T element, int index);

class BottomScrollSheet<T> extends ConsumerWidget {
  const BottomScrollSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DraggableScrollableSheet(
      controller: ref.watch(bottomSheetControllerProvider),
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
                child: BuildingsListView(scrollController),
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
