import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";

import "../../config/map_view_config.dart";
import "../../config/ui_config.dart";
import "../../theme/app_theme.dart";
import "../../utils/context_extensions.dart";
import "../multilayer_map/data/model/multilayer_item.dart";
import "../multilayer_map/data/model/multilayer_section_type.dart";
import "multilayer_map_single_entity_list.dart";
import "use_tab_scroll_sync.dart";

typedef TabData = ({
  String title,
  MultilayerSectionType sectionType,
  MultilayerMapSingleEntityList<MultilayerItem> Function() builder,
});

/// Helper widget to build slivers for multi-tab view
class SliverMultiTabberBuilder extends HookWidget {
  const SliverMultiTabberBuilder({required this.tabs, required this.scrollController, this.initialSectionType});

  final List<TabData> tabs;
  final ScrollController scrollController;

  /// The section type to scroll to initially.
  final MultilayerSectionType? initialSectionType;

  @override
  Widget build(BuildContext context) {
    final sectionKeys = useMemoized(() => List.generate(tabs.length, (_) => GlobalKey()), [tabs.length]);

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
                    tabs: tabs,
                    scrollController: scrollController,
                    sectionKeys: sectionKeys,
                    initialSectionType: initialSectionType,
                  ),
                ),
              ),
            ),
            height: context.textScaler.clamp(maxScaleFactor: 2).scale(40),
          ),
        ),
        // Add each tab's content
        for (var i = 0; i < tabs.length; i++)
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
                sliver: tabs[i].builder(),
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
    required this.scrollController,
    required this.sectionKeys,
    this.initialSectionType,
  });

  final List<TabData> tabs;
  final ScrollController scrollController;
  final List<GlobalKey> sectionKeys;
  final MultilayerSectionType? initialSectionType;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tabController = useTabController(initialLength: tabs.length);
    final (:selectedTabIndex, :onTabTap) = useTabScrollSync(
      sectionKeys: sectionKeys,
      scrollController: scrollController,
      tabController: tabController,
      ref: ref,
    );

    // Scroll to initial section if specified
    useEffect(() {
      if (initialSectionType != null) {
        final index = tabs.indexWhere((tab) => tab.sectionType == initialSectionType);
        if (index > 0) {
          // Only scroll if not the first tab (which is already visible)
          WidgetsBinding.instance.addPostFrameCallback((_) => onTabTap(index));
        }
      }
      return null;
    }, [initialSectionType]);

    return Theme(
      data: Theme.of(context).copyWith(splashColor: Colors.transparent, highlightColor: Colors.transparent),
      child: TabBar(
        controller: tabController,
        labelPadding: const EdgeInsets.symmetric(horizontal: NavigationTabViewConfig.smallerPadding),
        onTap: onTabTap,
        isScrollable: true,
        padding: EdgeInsets.zero,
        indicatorColor: Colors.transparent,
        dividerHeight: 0,
        tabAlignment: TabAlignment.start,
        tabs: List.generate(
          tabs.length,
          (index) => Container(
            key: ValueKey("tab_$index"),
            margin: EdgeInsets.only(
              bottom: NavigationTabViewConfig.smallerPadding * 1.5,
              left: index == 0
                  ? MapViewBottomSheetConfig.horizontalPadding - NavigationTabViewConfig.smallerPadding
                  : 0,
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: NavigationTabViewConfig.universalPadding,
              vertical: NavigationTabViewConfig.tinyPadding,
            ),
            decoration: BoxDecoration(
              color: index == selectedTabIndex.value
                  ? context.colorScheme.primaryContainer
                  : context.colorScheme.surfaceTint,
              borderRadius: BorderRadius.circular(NavigationTabViewConfig.radius),
            ),
            child: Text(
              tabs[index].title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: index == selectedTabIndex.value ? FontWeight.bold : FontWeight.normal,
                color: index == selectedTabIndex.value ? Colors.white : Colors.black,
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
