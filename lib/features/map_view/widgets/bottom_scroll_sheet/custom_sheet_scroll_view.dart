import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../theme/app_theme.dart';
import '../../../../utils/context_extensions.dart';
import '../../../../widgets/search_box_app_bar.dart';
import '../../controllers/active_map_marker_cntrl.dart';
import '../../controllers/buildings_listview_controller.dart';
import 'drag_handle.dart';

class CustomSheetScrollView extends ConsumerWidget {
  const CustomSheetScrollView({
    super.key,
    required this.body,
    required this.scrollController,
  });

  final Widget body;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CustomScrollView(
      controller: scrollController,
      slivers: [
        const SliverPersistentHeader(
          pinned: true,
          delegate: DragHandle(),
        ),
        SliverAppBar(
          pinned: true,
          flexibleSpace: SearchBoxAppBar(
            context,
            primary: false,
            title: context.localize?.buildings_title ?? "",
            onQueryChanged: ref
                .watch(buildingsListViewControllerProvider.notifier)
                .onSearchQueryChanged,
            actions: [
              if (ref.watch(activeMapMarkerControllerProvider) != null)
                const _NavigateButton(),
            ],
          ),
        ),
        SliverToBoxAdapter(child: body),
      ],
    );
  }
}

class _NavigateButton extends StatelessWidget {
  const _NavigateButton();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 13),
      child: TextButton(
        onPressed: () {},
        child: Text(
          context.localize?.navigate ?? "",
          style: context.textTheme.boldBodyOrange,
        ),
      ),
    );
  }
}
