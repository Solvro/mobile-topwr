import "dart:async";

import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";

import "../../../theme/app_theme.dart";
import "../../config/map_view_config.dart";
import "../../config/ui_config.dart";
import "../../utils/context_extensions.dart";
import "../../utils/where_non_null_iterable.dart";
import "../../widgets/search_box_app_bar.dart";
import "../analytics/data/umami.dart";
import "../analytics/data/umami_events.dart";
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
          ..._buildMultiTabSlivers(context, ref, tabs, scrollController ?? ScrollController()),
        if (categoryData == null || areOnlyOneLayerEnabled) DataSliverList<T>(),
        if (isNoTabs && categoryData != null)
          SliverFillRemaining(child: Center(child: Text(context.localize.no_layers_available))),
        const SliverToBoxAdapter(child: SizedBox(height: SearchBoxAppBar.defaultBottomPadding)),
      ],
    );
  }

  List<Widget> _buildMultiTabSlivers(
    BuildContext context,
    WidgetRef ref,
    List<({String title, MultilayerMapSingleEntityList<MultilayerItem> Function() builder})> tabs,
    ScrollController scrollController,
  ) {
    return [_SliverTabBuilder(tabs: tabs, scrollController: scrollController, ref: ref)];
  }
}

/// Helper widget to build slivers for multi-tab view
class _SliverTabBuilder extends StatefulWidget {
  const _SliverTabBuilder({required this.tabs, required this.scrollController, required this.ref});

  final List<({String title, MultilayerMapSingleEntityList<MultilayerItem> Function() builder})> tabs;
  final ScrollController scrollController;
  final WidgetRef ref;

  @override
  State<_SliverTabBuilder> createState() => _SliverTabBuilderState();
}

class _SliverTabBuilderState extends State<_SliverTabBuilder> {
  late final List<GlobalKey> sectionKeys;
  late final ValueNotifier<int> selectedTabIndex;

  @override
  void initState() {
    super.initState();
    sectionKeys = List.generate(widget.tabs.length, (_) => GlobalKey());
    selectedTabIndex = ValueNotifier(0);
  }

  @override
  void dispose() {
    selectedTabIndex.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SliverMainAxisGroup(slivers: _buildSlivers(context));
  }

  List<Widget> _buildSlivers(BuildContext context) {
    return [
      SliverPersistentHeader(
        pinned: true,
        delegate: _MultiTabHeaderDelegate(
          child: Align(
            alignment: Alignment.centerLeft,
            child: SizedBox(
              height: context.textScaler.clamp(maxScaleFactor: 2).scale(40),
              child: _TabBarWidget(
                tabs: widget.tabs,
                selectedTabIndex: selectedTabIndex,
                scrollController: widget.scrollController,
                sectionKeys: sectionKeys,
              ),
            ),
          ),
          height: context.textScaler.clamp(maxScaleFactor: 2).scale(40),
        ),
      ),
      // Add each tab's content
      for (var i = 0; i < widget.tabs.length; i++)
        SliverMainAxisGroup(
          slivers: [
            // Add a trackable marker widget at the start of each section
            SliverToBoxAdapter(
              child: Container(key: sectionKeys[i], height: 10, color: Colors.transparent),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(
                horizontal: MapViewBottomSheetConfig.horizontalPadding,
                vertical: NavigationTabViewConfig.universalPadding,
              ),
              sliver: widget.tabs[i].builder(),
            ),
          ],
        ),
    ];
  }
}

/// Widget for the tab bar
class _TabBarWidget extends HookConsumerWidget {
  const _TabBarWidget({
    required this.tabs,
    required this.selectedTabIndex,
    required this.scrollController,
    required this.sectionKeys,
  });

  final List<({String title, MultilayerMapSingleEntityList<MultilayerItem> Function() builder})> tabs;
  final ValueNotifier<int> selectedTabIndex;
  final ScrollController scrollController;
  final List<GlobalKey> sectionKeys;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tabController = useTabController(initialLength: tabs.length);
    final isScrollingToTab = useRef(false);

    // Listen to scroll to update active tab
    useEffect(() {
      void onScroll() {
        if (isScrollingToTab.value) return;

        // Find the first section that's visible near the top
        for (var i = sectionKeys.length - 1; i >= 0; i--) {
          final ctx = sectionKeys[i].currentContext;
          if (ctx == null) continue;

          final renderBox = ctx.findRenderObject() as RenderBox?;
          if (renderBox == null || !renderBox.attached || !renderBox.hasSize) continue;

          final position = renderBox.localToGlobal(Offset.zero);

          // If this section's marker is at or above 200px from top, it's active
          if (position.dy <= 200) {
            if (selectedTabIndex.value != i) {
              selectedTabIndex.value = i;
              if (tabController.index != i) {
                tabController.animateTo(i);
              }
            }
            break;
          }
        }
      }

      scrollController.addListener(onScroll);
      return () => scrollController.removeListener(onScroll);
    }, [scrollController]);

    // Sync tab controller with selected index
    useEffect(() {
      void listener() {
        if (tabController.index != selectedTabIndex.value) {
          tabController.animateTo(selectedTabIndex.value);
        }
      }

      selectedTabIndex.addListener(listener);
      return () => selectedTabIndex.removeListener(listener);
    }, []);

    return Theme(
      data: Theme.of(context).copyWith(splashColor: Colors.transparent, highlightColor: Colors.transparent),
      child: TabBar(
        controller: tabController,
        onTap: (index) async {
          final ctx = sectionKeys[index].currentContext;
          if (ctx != null) {
            isScrollingToTab.value = true;
            selectedTabIndex.value = index;
            await Scrollable.ensureVisible(ctx, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
            await Future<void>.delayed(const Duration(milliseconds: 50));
            if (ctx.mounted) {
              // ! this is nasty hack due to some bug
              await Scrollable.ensureVisible(ctx);
              await Future<void>.delayed(const Duration(milliseconds: 200));
            }
            isScrollingToTab.value = false;
          }
        },
        isScrollable: true,
        padding: EdgeInsets.zero,
        indicatorColor: Colors.transparent,
        dividerHeight: 0,
        tabs: List.generate(
          tabs.length,
          (index) => ValueListenableBuilder(
            key: ValueKey("tab_$index"),
            valueListenable: selectedTabIndex,
            builder: (context, selectedIndex, child) => Container(
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
                color: index == selectedIndex
                    ? context.colorTheme.orangePomegranadeLighter
                    : context.colorTheme.greyLight,
                borderRadius: BorderRadius.circular(NavigationTabViewConfig.radius),
              ),
              child: Text(
                tabs[index].title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: index == selectedIndex ? FontWeight.bold : FontWeight.normal,
                  color: index == selectedIndex ? Colors.white : Colors.black,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Delegate for the multi-tab header
class _MultiTabHeaderDelegate extends SliverPersistentHeaderDelegate {
  _MultiTabHeaderDelegate({required this.child, required this.height});

  final Widget child;
  final double height;

  @override
  double get minExtent => height;

  @override
  double get maxExtent => height;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.white,
      child: child,
    );
  }

  @override
  bool shouldRebuild(_MultiTabHeaderDelegate oldDelegate) {
    return oldDelegate.child != child || oldDelegate.height != height;
  }
}
