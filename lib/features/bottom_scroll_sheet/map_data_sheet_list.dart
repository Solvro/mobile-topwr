import "dart:async";

import "package:flutter/material.dart";

import "package:hooks_riverpod/hooks_riverpod.dart";

import "../../config/ui_config.dart";
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
import "../parkings/parkings_view/widgets/parking_info_button.dart";
import "active_map_item_sliver.dart";
import "data_list.dart";
import "drag_handle.dart";
import "hooks/use_initial_active_id.dart";
import "hooks/use_preserved_scroll_offset.dart";
import "multilayer_map_single_entity_list.dart";
import "navigate_button.dart";
import "sliver_multi_tabber_builder.dart";

class MapDataSheetList<T extends GoogleNavigable> extends HookConsumerWidget {
  const MapDataSheetList({required this.scrollController, this.topSafeAreaPadding = 0, super.key});

  final ScrollController scrollController;
  final double topSafeAreaPadding;

  /// Pinned slivers + fractional extents can trip `remainingPaintExtent` by one ULP (short viewports).
  static double _quantizeLayoutExtent(double value) => value.roundToDouble();

  @override
  // ignore: solvro_config/cognitive_complexity if it works, do not touch it. But if someone is going to fix/tweak/change that, then in such case, pls remove rule override and do a nice cleanup
  Widget build(BuildContext context, WidgetRef ref) {
    final activeItem = ref.watch(context.activeMarkerController<T>());
    final isLoading = ref.watch(context.mapDataController<T>().select((a) => a.value == null));
    final isMultilayerMap =
        T == MultilayerItem &&
        activeItem == null &&
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
      actions: [
        if (T == Parking && activeItem == null) const ParkingInfoButton(),
        if (activeItem != null) NavigateButton<T>(),
      ],
      initialQuery: context.initialQuery<T>(),
    );

    final categoryData = isMultilayerMap
        ? (
            buildings: (
              title: context.localize.buildings_title,
              sectionType: MultilayerSectionType.building,
              builder: MultilayerMapSingleEntityList<BuildingItem>.new,
            ),
            polinkas: (
              title: context.localize.polinka_prefix,
              sectionType: MultilayerSectionType.polinka,
              builder: MultilayerMapSingleEntityList<PolinkaItem>.new,
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
          polinkasEnabled: false,
          librariesEnabled: false,
          aedsEnabled: false,
          bicycleShowersEnabled: false,
          pinkBoxesEnabled: false,
        );

    final tabs = [
      // this dictates the order of the tabs
      if (layersEnabled.buildingsEnabled && (ref.watch(hasAnyBuildingItemsProvider).value ?? false))
        categoryData?.buildings,
      if (layersEnabled.polinkasEnabled && (ref.watch(hasAnyPolinkaItemsProvider).value ?? false))
        categoryData?.polinkas,
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

    usePreservedSheetPosition<T>(context, ref, scrollController: scrollController);

    return CustomScrollView(
      key: MyAppConfig.verticalScrollableKey,
      controller: scrollController,
      // Active item is a single tile — disable scrolling so shrinking content
      // cannot clamp the prior list offset a frame later.
      physics: activeItem != null ? const NeverScrollableScrollPhysics() : null,
      slivers: [
        SliverPersistentHeader(
          pinned: true,
          delegate: DragHandle(topPadding: _quantizeLayoutExtent(topSafeAreaPadding)),
        ),
        SliverAppBar(
          primary: false,
          pinned: true,
          toolbarHeight: _quantizeLayoutExtent(appBar.preferredSize.height),
          flexibleSpace: appBar,
          automaticallyImplyLeading: false,
        ),

        if (activeItem != null)
          ActiveMapItemSliver<T>(activeItem)
        else if (categoryData != null && !areOnlyOneLayerEnabled && !isNoTabs)
          SliverMultiTabberBuilder(
            tabs: tabs,
            scrollController: scrollController,
            initialSectionType: context.initialSectionType<T>(),
          )
        else if (categoryData == null || areOnlyOneLayerEnabled)
          DataSliverList<T>()
        else
          // Multilayer with no enabled layers that have items.
          SliverFillRemaining(child: Center(child: Text(context.localize.no_layers_available))),
        if (activeItem == null) const SliverToBoxAdapter(child: SizedBox(height: SearchBoxAppBar.defaultBottomPadding)),
      ],
    );
  }
}
