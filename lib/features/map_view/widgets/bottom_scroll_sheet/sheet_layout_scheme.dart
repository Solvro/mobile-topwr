import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../utils/context_extensions.dart';
import '../../../../widgets/search_box_app_bar.dart';
import '../../controllers/bottom_sheet_controller.dart';
import '../map_config.dart';
import 'data_list.dart';
import 'drag_handle.dart';
import 'navigate_button.dart';

class SheetLayoutScheme<T> extends ConsumerWidget {
  const SheetLayoutScheme({
    this.scrollController,
    super.key,
  });

  final ScrollController? scrollController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appBar = SearchBoxAppBar(
      context,
      primary: false,
      title: context.localize.buildings_title,
      onQueryChanged: ref
          .watch(context.mapDataController<T>().notifier)
          .onSearchQueryChanged,
      onSearchboxTap:
          ref.watch(bottomSheetPixelsProvider.notifier).onSearchBoxTap,
      actions: [
        if (ref.watch(context.mapController<T>()) != null) NavigateButton<T>(),
      ],
    );

    return CustomScrollView(
      controller: scrollController,
      slivers: [
        const SliverPersistentHeader(
          pinned: true,
          delegate: DragHandle(),
        ),
        SliverAppBar(
          primary: false,
          pinned: true,
          toolbarHeight: appBar.preferredSize.height,
          flexibleSpace: appBar,
        ),
        DataSliverList<T>(),
      ],
    );
  }
}
