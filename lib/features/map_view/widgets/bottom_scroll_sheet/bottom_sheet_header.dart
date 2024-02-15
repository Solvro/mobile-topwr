import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../theme/app_theme.dart';
import '../../../../utils/context_extensions.dart';
import '../../../../widgets/search_widget.dart';
import '../../controllers/active_map_marker_cntrl.dart';
import '../../controllers/buildings_listview_controller.dart';
import 'drag_handle_section.dart';

class BottomSheetHeader extends ConsumerWidget {
  const BottomSheetHeader({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DecoratedBox(
      decoration: BoxDecoration(color: context.colorTheme.whiteSoap),
      child: Column(
        children: [
          const DragHandleSection(),
          const _HeaderTextAndButtonTile(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: SearchWidget(
              onQueryChanged: (query) {
                ref
                    .read(buildingsListViewControllerProvider.notifier)
                    .updateSearchText(query);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _HeaderTextAndButtonTile extends ConsumerWidget {
  const _HeaderTextAndButtonTile();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.only(left: 24, right: 12),
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            context.localize?.buildings_title ?? "",
            style: context.textTheme.headline,
          ),
          if (ref.watch(activeMapMarkerControllerProvider) != null)
            TextButton(
              onPressed: () {},
              child: Text(
                context.localize?.navigate ?? "",
                style: context.textTheme.boldBodyOrange,
              ),
            ),
        ],
      ),
    );
  }
}
