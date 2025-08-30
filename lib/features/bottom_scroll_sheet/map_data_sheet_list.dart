import "dart:async";

import "package:flutter/material.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";

import "../../../theme/app_theme.dart";
import "../../config/ui_config.dart";
import "../../utils/context_extensions.dart";
import "../../widgets/search_box_app_bar.dart";
import "../analytics/data/umami.dart";
import "../analytics/data/umami_events.dart";
import "../bottom_scroll_sheet/scrollable_list_tab_scroller/scrollable_list_tab_scroller.dart";
import "../buildings_view/data/model/building.dart";
import "../buildings_view/data/model/multilayer_item.dart";
import "../map_view/controllers/bottom_sheet_controller.dart";
import "../map_view/controllers/controllers_set.dart";
import "../map_view/widgets/map_config.dart";
import "../parkings/parkings_view/models/parking.dart";
import "data_list.dart";
import "data_list_widget.dart";
import "drag_handle.dart";
import "navigate_button.dart";

class MapDataSheetList<T extends GoogleNavigable> extends HookConsumerWidget {
  const MapDataSheetList({this.scrollController, super.key});

  final ScrollController? scrollController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isMultilayerMap = T == MultilayerItem;
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

    final categoryData = isMultilayerMap
        ? (
            buildings: (title: context.localize.buildings_title, builder: DataListWidget<BuildingItem>.new),
            library: (title: context.localize.library_title, builder: DataListWidget<LibraryItem>.new),
            aed: (title: context.localize.aed_title, builder: DataListWidget<AedItem>.new),
            showers: (
              title: context.localize.showers_title,
              builder: () => const Column(
                children: [
                  ListTile(title: Text("lorem ipsum")),
                  ListTile(title: Text("lorem ipsum")),
                  ListTile(title: Text("lorem ipsum")),
                  ListTile(title: Text("lorem ipsum")),
                  ListTile(title: Text("lorem ipsum")),
                ],
              ),
            ),
            pinkBoxes: (
              title: context.localize.pink_boxes_title,
              builder: () => const Column(
                children: [
                  ListTile(title: Text("lorem ipsum")),
                  ListTile(title: Text("lorem ipsum")),
                  ListTile(title: Text("lorem ipsum")),
                  ListTile(title: Text("lorem ipsum")),
                  ListTile(title: Text("lorem ipsum")),
                ],
              ),
            ),
          )
        : null;

    final tabs = [
      categoryData?.buildings,
      categoryData?.library,
      categoryData?.showers,
      categoryData?.pinkBoxes,
      categoryData?.aed,
    ].where((tab) => tab != null).cast<({String title, Widget Function() builder})>().toList();

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
        if (categoryData != null)
          SliverFillRemaining(
            child: ScrollableListTabScroller(
              itemCount: tabs.length,
              tabBuilder: (BuildContext context, int index, bool active) => Container(
                margin: const EdgeInsets.only(right: NavigationTabViewConfig.smallerPadding),
                padding: const EdgeInsets.symmetric(
                  horizontal: NavigationTabViewConfig.universalPadding,
                  vertical: NavigationTabViewConfig.smallerPadding,
                ),
                decoration: BoxDecoration(
                  color: active ? context.colorTheme.orangePomegranadeLighter : context.colorTheme.greyLight,
                  borderRadius: BorderRadius.circular(NavigationTabViewConfig.radius),
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
                padding: const EdgeInsets.all(NavigationTabViewConfig.universalPadding),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(NavigationTabViewConfig.smallerPadding),
                      child: Text(tabs[index].title, style: context.textTheme.headline),
                    ),
                    tabs[index].builder(),
                  ],
                ),
              ),
            ),
          ),
        const SliverToBoxAdapter(child: SizedBox(height: SearchBoxAppBar.defaultBottomPadding)),
        if (categoryData == null) DataSliverList<T>(),
      ],
    );
  }
}
