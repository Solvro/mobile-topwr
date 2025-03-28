import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../widgets/search_box_app_bar.dart";
import "../map_view/controllers/bottom_sheet_controller.dart";
import "../map_view/controllers/controllers_set.dart";
import "../map_view/widgets/map_config.dart";
import "data_list.dart";
import "drag_handle.dart";
import "navigate_button.dart";

class SheetLayoutScheme<T extends GoogleNavigable> extends ConsumerWidget {
  const SheetLayoutScheme({this.scrollController, super.key});

  final ScrollController? scrollController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appBar = SearchBoxAppBar(
      context,
      title: context.mapViewTexts<T>().title,
      onQueryChanged: ref.watch(context.mapDataController<T>().notifier).onSearchQueryChanged,
      onSearchBoxTap: ref.watch(bottomSheetPixelsProvider.notifier).onSearchBoxTap,
      actions: [if (ref.watch(context.activeMarkerController<T>()) != null) NavigateButton<T>()],
    );

    return CustomScrollView(
      controller: scrollController,
      slivers: [
        const SliverPersistentHeader(pinned: true, delegate: DragHandle()),
        SliverAppBar(
          primary: false,
          pinned: true,
          toolbarHeight: appBar.preferredSize.height,
          flexibleSpace: appBar,
          automaticallyImplyLeading: false,
        ),
        DataSliverList<T>(),
      ],
    );
  }
}
