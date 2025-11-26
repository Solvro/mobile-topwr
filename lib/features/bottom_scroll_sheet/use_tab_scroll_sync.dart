import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";

import "../map_view/controllers/bottom_sheet_controller.dart";

/// Custom hook to sync tab selection with scroll position and handle tab taps
({ValueNotifier<int> selectedTabIndex, Future<void> Function(int) onTabTap}) useTabScrollSync({
  required List<GlobalKey> sectionKeys,
  required ScrollController scrollController,
  required TabController tabController,
  required WidgetRef ref,
}) {
  final selectedTabIndex = useState(0);
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

  final onTabTap = useCallback((int index) async {
    final ctx = sectionKeys[index].currentContext;
    if (ctx != null) {
      isScrollingToTab.value = true;
      selectedTabIndex.value = index;

      // First expand the bottom sheet fully
      await ref.watch(bottomSheetPixelsProvider.notifier).fullyExpandSheet();
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
  }, [sectionKeys, ref]);

  return (selectedTabIndex: selectedTabIndex, onTabTap: onTabTap);
}
