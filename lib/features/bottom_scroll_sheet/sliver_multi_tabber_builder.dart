import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";

import "../../config/map_view_config.dart";
import "../../config/ui_config.dart";
import "../../theme/app_theme.dart";
import "../../utils/context_extensions.dart";
import "../map_view/controllers/bottom_sheet_controller.dart";
import "../multilayer_map/data/model/multilayer_item.dart";
import "multilayer_map_single_entity_list.dart";

/// Helper widget to build slivers for multi-tab view
class SliverMultiTabberBuilder extends StatefulWidget {
  const SliverMultiTabberBuilder({required this.tabs, required this.scrollController});

  final List<({String title, MultilayerMapSingleEntityList<MultilayerItem> Function() builder})> tabs;
  final ScrollController scrollController;

  @override
  State<SliverMultiTabberBuilder> createState() => _SliverMultiTabberBuilderState();
}

class _SliverMultiTabberBuilderState extends State<SliverMultiTabberBuilder> {
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
    return SliverMainAxisGroup(
      slivers: [
        SliverPersistentHeader(
          pinned: true,
          delegate: _MultiTabHeaderDelegate(
            child: SizedBox(
              width: double.infinity,
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
                child: Container(key: sectionKeys[i], height: 5, color: Colors.transparent),
              ),
              SliverPadding(
                padding: i == 0
                    ? const EdgeInsets.symmetric(horizontal: MapViewBottomSheetConfig.horizontalPadding)
                    : const EdgeInsets.symmetric(
                        horizontal: MapViewBottomSheetConfig.horizontalPadding,
                        vertical: NavigationTabViewConfig.smallerPadding,
                      ),
                sliver: widget.tabs[i].builder(),
              ),
            ],
          ),
      ],
    );
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

            // First expand the bottom sheet fully
            await ref.watch(bottomSheetPixelsProvider.notifier).onSearchBoxTap();
            if (ctx.mounted) {
              await Scrollable.ensureVisible(ctx, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
              await Future<void>.delayed(const Duration(milliseconds: 50));
              if (ctx.mounted) {
                // ! this is nasty hack due to some bug with the `Scrollable.ensureVisible` overshooting while scrolling to the tab
                await Scrollable.ensureVisible(ctx, alignment: 0.08);
                await Future<void>.delayed(const Duration(milliseconds: 200));
              }
            }
            isScrollingToTab.value = false;
          }
        },
        isScrollable: true,
        padding: EdgeInsets.zero,
        indicatorColor: Colors.transparent,
        dividerHeight: 0,
        tabAlignment: TabAlignment.start,
        tabs: List.generate(
          tabs.length,
          (index) => ValueListenableBuilder(
            key: ValueKey("tab_$index"),
            valueListenable: selectedTabIndex,
            builder: (context, selectedIndex, child) => Container(
              margin: EdgeInsets.only(bottom: NavigationTabViewConfig.smallerPadding * 1.5, left: index == 0 ? 8 : 0),
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
    return ColoredBox(color: Colors.white, child: child);
  }

  @override
  bool shouldRebuild(_MultiTabHeaderDelegate oldDelegate) {
    return oldDelegate.child != child || oldDelegate.height != height;
  }
}
