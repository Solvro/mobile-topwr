import "dart:async";

import "package:flutter/material.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";

import "../../../theme/app_theme.dart";
import "../../config/map_view_config.dart";
import "../../config/ui_config.dart";
import "../../utils/context_extensions.dart";
import "../../utils/where_non_null_iterable.dart";
import "../../widgets/search_box_app_bar.dart";
import "../analytics/data/umami.dart";
import "../analytics/data/umami_events.dart";
import "../bottom_scroll_sheet/scrollable_list_tab_scroller/scrollable_list_tab_scroller.dart";
import "../map_layer_picker/business/layers_enabled_service.dart";
import "../map_view/controllers/bottom_sheet_controller.dart";
import "../map_view/controllers/controllers_set.dart";
import "../map_view/widgets/map_config.dart";
import "../multilayer_map/business/multilayer_source_service.dart";
import "../multilayer_map/data/model/multilayer_item.dart";
import "../parkings/parkings_view/models/parking.dart";
import "data_list.dart";
import "drag_handle.dart";
import "hooks/use_initial_active_id.dart";
import "multilayer_map_single_entity_list.dart";
import "navigate_button.dart";

class MapDataSheetList<T extends GoogleNavigable> extends HookConsumerWidget {
  const MapDataSheetList({this.scrollController, super.key});

  final ScrollController? scrollController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(context.mapDataController<T>().select((a) => a.valueOrNull == null));
    final isMultilayerMap =
        T == MultilayerItem &&
        ref.watch(
          context.activeMarkerController<T>().select((a) => a == null),
        ) // when active marker is not null, we do not show multitabs
        &&
        ref.watch(
          context.mapDataController<T>().select((a) => a.valueOrNull?.isFilterStrEmpty ?? true),
        ) // when we search in the search box, we do not show multitabs
        &&
        !isLoading // when we are loading, we do not show multitabs
        ;
    final appBar = SearchBoxAppBar(
      context,
      title: context.mapViewTexts<T>().title,
      onQueryChanged: ref.watch(context.mapDataController<T>().notifier).onSearchQueryChanged,
      onSearchBoxTap: () async {
        if (T == MultilayerItem) {
          unawaited(ref.trackEvent(UmamiEvents.searchMultilayerMap));
        } else if (T == Parking) {
          unawaited(ref.trackEvent(UmamiEvents.searchParkings));
        }
        await ref.watch(bottomSheetPixelsProvider.notifier).onSearchBoxTap();
      },
      actions: [if (ref.watch(context.activeMarkerController<T>()) != null) NavigateButton<T>()],
    );

    final categoryData = isMultilayerMap
        ? (
            buildings: (
              title: context.localize.buildings_title,
              builder: MultilayerMapSingleEntityList<BuildingItem>.new,
            ),
            library: (title: context.localize.library_title, builder: MultilayerMapSingleEntityList<LibraryItem>.new),
            aed: (title: context.localize.aed_title, builder: MultilayerMapSingleEntityList<AedItem>.new),
            showers: (
              title: context.localize.showers_title,
              builder: MultilayerMapSingleEntityList<BicycleShowerItem>.new,
            ),
            pinkBoxes: (
              title: context.localize.pink_boxes_title,
              builder: MultilayerMapSingleEntityList<PinkBoxItem>.new,
            ),
          )
        : null;
    final layersEnabled =
        ref.watch(layersEnabledServiceProvider).valueOrNull ??
        (
          buildingsEnabled: false,
          librariesEnabled: false,
          aedsEnabled: false,
          bicycleShowersEnabled: false,
          pinkBoxesEnabled: false,
        );

    final tabs = [
      // this dictates the order of the tabs
      if (layersEnabled.buildingsEnabled && (ref.watch(hasAnyBuildingItemsProvider).value ?? false))
        categoryData?.buildings,
      if (layersEnabled.librariesEnabled && (ref.watch(hasAnyLibraryItemsProvider).value ?? false))
        categoryData?.library,
      if (layersEnabled.aedsEnabled && (ref.watch(hasAnyAedItemsProvider).value ?? false)) categoryData?.aed,
      if (layersEnabled.pinkBoxesEnabled && (ref.watch(hasAnyPinkBoxItemsProvider).value ?? false))
        categoryData?.pinkBoxes,
      if (layersEnabled.bicycleShowersEnabled && (ref.watch(hasAnyBicycleShowerItemsProvider).value ?? false))
        categoryData?.showers,
    ].whereNonNull.toList();

    final areOnlyOneLayerEnabled = tabs.length == 1;
    final isNoTabs = tabs.isEmpty;

    useInitialActiveId(
      context.initialActiveItemId<T>(),
      ref.watch(context.activeMarkerController<T>().notifier),
      ref.watch(context.mapController<T>()).zoomOnMarker,
      ref.watch(context.mapDataController<T>()).valueOrNull?.data,
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

        if (categoryData != null && !areOnlyOneLayerEnabled && !isNoTabs)
          SliverFillRemaining(
            child: SizedBox(
              width: double.infinity,
              child: ScrollableListTabScroller(
                headerContainerBuilder: (context, child) => Align(
                  alignment: Alignment.centerLeft,
                  child: SizedBox(height: context.textScaler.clamp(maxScaleFactor: 2).scale(40), child: child),
                ),
                itemCount: tabs.length,
                tabBuilder: (BuildContext context, int index, bool active) => Container(
                  margin: EdgeInsets.only(
                    left: index == 0 ? MapViewBottomSheetConfig.horizontalPadding : 0,
                    right: index == tabs.length - 1
                        ? MapViewBottomSheetConfig.horizontalPadding
                        : NavigationTabViewConfig.smallerPadding,
                    bottom: NavigationTabViewConfig.smallerPadding * 1.5,
                  ),
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
                  padding: const EdgeInsets.symmetric(
                    horizontal: MapViewBottomSheetConfig.horizontalPadding,
                    vertical: NavigationTabViewConfig.universalPadding,
                  ),
                  child: tabs[index].builder(),
                ),
              ),
            ),
          ),
        if (categoryData == null || areOnlyOneLayerEnabled) DataSliverList<T>(),
        if (isNoTabs) SliverFillRemaining(child: Center(child: Text(context.localize.no_layers_available))),
        const SliverToBoxAdapter(child: SizedBox(height: SearchBoxAppBar.defaultBottomPadding)),
      ],
    );
  }
}
