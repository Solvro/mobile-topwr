import "dart:async";

import "package:flutter/material.dart";

import "package:hooks_riverpod/hooks_riverpod.dart";

import "../../utils/context_extensions.dart";
import "../../utils/where_non_null_iterable.dart";
import "../../widgets/search_box_app_bar.dart";
import "../analytics/data/clarity.dart";
import "../analytics/data/clarity_events.dart";
import "../map_layer_picker/business/layers_enabled_service.dart";
import "../map_view/controllers/bottom_sheet_controller.dart";
import "../map_view/controllers/controllers_set.dart";
import "../map_view/widgets/map_config.dart";
import "../multilayer_map/business/multilayer_source_service.dart";
import "../multilayer_map/data/model/multilayer_item.dart";
import "../multilayer_map/data/model/multilayer_section_type.dart";
import "../parkings/parkings_view/models/parking.dart";
import "data_list.dart";
import "drag_handle.dart";
import "hooks/use_initial_active_id.dart";
import "multilayer_map_single_entity_list.dart";
import "navigate_button.dart";
import "sliver_multi_tabber_builder.dart";

class MapDataSheetList<T extends GoogleNavigable> extends HookConsumerWidget {
  const MapDataSheetList({required this.scrollController, super.key});

  final ScrollController scrollController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(context.mapDataController<T>().select((a) => a.value == null));
    final isMultilayerMap =
        T == MultilayerItem &&
        ref.watch(
          context.activeMarkerController<T>().select((a) => a == null),
        ) // when active marker is not null, we do not show multitabs
        &&
        ref.watch(
          context.mapDataController<T>().select((a) => a.value?.isFilterStrEmpty ?? true),
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
          unawaited(ref.trackEvent(ClarityEvents.searchMultilayerMap));
        } else if (T == Parking) {
          unawaited(ref.trackEvent(ClarityEvents.searchParkings));
        }
        await ref.read(bottomSheetPixelsProvider.notifier).expandSheet();
      },
      actions: [if (ref.watch(context.activeMarkerController<T>()) != null) NavigateButton<T>()],
      initialQuery: context.initialQuery<T>(),
    );

    final categoryData = isMultilayerMap
        ? (
            buildings: (
              title: context.localize.buildings_title,
              sectionType: MultilayerSectionType.building,
              builder: MultilayerMapSingleEntityList<BuildingItem>.new,
            ),
            library: (
              title: context.localize.library_title,
              sectionType: MultilayerSectionType.library,
              builder: MultilayerMapSingleEntityList<LibraryItem>.new,
            ),
            aed: (
              title: context.localize.aed_title,
              sectionType: MultilayerSectionType.aed,
              builder: MultilayerMapSingleEntityList<AedItem>.new,
            ),
            showers: (
              title: context.localize.showers_title,
              sectionType: MultilayerSectionType.bicycleShower,
              builder: MultilayerMapSingleEntityList<BicycleShowerItem>.new,
            ),
            pinkBoxes: (
              title: context.localize.pink_boxes_title,
              sectionType: MultilayerSectionType.pinkBox,
              builder: MultilayerMapSingleEntityList<PinkBoxItem>.new,
            ),
          )
        : null;
    final layersEnabled =
        ref.watch(layersEnabledServiceProvider).value ??
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
      ref.watch(context.mapDataController<T>()).value?.data,
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
          SliverMultiTabberBuilder(
            tabs: tabs,
            scrollController: scrollController,
            initialSectionType: context.initialSectionType<T>(),
          ),
        if (categoryData == null || areOnlyOneLayerEnabled) DataSliverList<T>(),
        if (isNoTabs && categoryData != null)
          SliverFillRemaining(child: Center(child: Text(context.localize.no_layers_available))),
        const SliverToBoxAdapter(child: SizedBox(height: SearchBoxAppBar.defaultBottomPadding)),
      ],
    );
  }
}
