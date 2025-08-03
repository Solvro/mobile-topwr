import "dart:async";

import "package:flutter/material.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:scrollable_list_tab_scroller/scrollable_list_tab_scroller.dart";

import "../../../theme/app_theme.dart";
import "../../utils/context_extensions.dart";
import "../../widgets/my_error_widget.dart";
import "../../widgets/search_box_app_bar.dart";
import "../analytics/data/umami.dart";
import "../analytics/data/umami_events.dart";
import "../buildings_view/model/building.dart";
import "../map_view/controllers/bottom_sheet_controller.dart";
import "../map_view/controllers/controllers_set.dart";
import "../map_view/widgets/map_config.dart";
import "../parkings/parkings_view/models/parking.dart";
import "drag_handle.dart";
import "navigate_button.dart";

class SheetLayoutScheme<T extends GoogleNavigable> extends HookConsumerWidget {
  const SheetLayoutScheme({this.scrollController, super.key});

  final ScrollController? scrollController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appBar = SearchBoxAppBar(
      context,
      title: context.mapViewTexts<T>().title,
      onQueryChanged: ref.watch(context.mapDataController<T>().notifier).onSearchQueryChanged,
      onSearchBoxTap: () async {
        if (T == Building) {
          unawaited(ref.trackEvent(UmamiEvents.searchBuilding));
        } else if (T == Parking) {
          unawaited(ref.trackEvent(UmamiEvents.searchParkings));
        }
        await ref.watch(bottomSheetPixelsProvider.notifier).onSearchBoxTap();
      },
      actions: [if (ref.watch(context.activeMarkerController<T>()) != null) NavigateButton<T>()],
    );

    final categoryData = (
      buildings: (title: context.localize.buildings_title, builder: () => _buildDataList<T>(ref, context)),
      library: (
        title: context.localize.library_title,
        builder: () => const Column(
          children: [
            ListTile(title: Text("Biblioteka 1")),
            ListTile(title: Text("Biblioteka 2")),
            ListTile(title: Text("Biblioteka 3")),
            ListTile(title: Text("Biblioteka 4")),
            ListTile(title: Text("Biblioteka 5")),
            ListTile(title: Text("Biblioteka 6")),
            ListTile(title: Text("Biblioteka 7")),
            ListTile(title: Text("Biblioteka 8")),
            ListTile(title: Text("Biblioteka 9")),
          ],
        ),
      ),
      showers: (
        title: context.localize.showers_title,
        builder: () => const Column(
          children: [
            ListTile(title: Text("Prysznic 1 ")),
            ListTile(title: Text("Prysznic 2")),
          ],
        ),
      ),
    );

    final List<({String title, Widget Function() builder})> tabs = [
      categoryData.buildings,
      categoryData.library,
      categoryData.showers,
    ];

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
        if (tabs.isNotEmpty)
          SliverFillRemaining(
            child: ScrollableListTabScroller(
              itemCount: tabs.length,
              tabBuilder: (BuildContext context, int index, bool active) => Container(
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 4),
                decoration: BoxDecoration(
                  color: active ? context.colorTheme.orangePomegranadeLighter : context.colorTheme.greyLight,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text(
                  tabs[index].title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: active ? FontWeight.bold : FontWeight.normal,
                    color: active ? Colors.white : Colors.black,
                  ),
                ),
              ),

              itemBuilder: (BuildContext context, int index) => Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Text(tabs[index].title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    tabs[index].builder(),
                  ],
                ),
              ),
            ),
          ),
        const SliverToBoxAdapter(child: SizedBox(height: SearchBoxAppBar.defaultBottomPadding)),
      ],
    );
  }
}

Widget _buildDataList<T extends GoogleNavigable>(WidgetRef ref, BuildContext context) {
  final itemsState = ref.watch(context.mapDataController<T>());

  return switch (itemsState) {
    AsyncError(:final error, :final stackTrace) => MyErrorWidget(error, stackTrace: stackTrace),
    AsyncValue(:final value) when value != null => Column(
      children: value
          .map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: context.mapTileBuilder<T>()(item, isActive: false),
            ),
          )
          .toList(),
    ),
    _ => const CircularProgressIndicator(),
  };
}
