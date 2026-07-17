// ignore_for_file: solvro_config/cognitive_complexity if it works, do not touch it. But if someone is going to fix/tweak/change that, then in such case, pls remove rule override and do a nice cleanup

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
  final sheet = ref.read(bottomSheetControllerProvider);
  final restoredTabIndex = useMemoized(() {
    final pending = sheet.takePendingTabIndex();
    if (pending == null || sectionKeys.isEmpty) {
      return 0;
    }
    return pending.clamp(0, sectionKeys.length - 1);
  });

  final selectedTabIndex = useState(restoredTabIndex);
  final isScrollingToTab = useRef(false);

  // Apply restored tab to TabController once after remount (e.g. marker deactivate).
  useEffect(() {
    if (restoredTabIndex <= 0) {
      return null;
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (tabController.index != restoredTabIndex) {
        tabController.index = restoredTabIndex;
      }
      sheet.lastSyncedTabIndex = restoredTabIndex;
    });
    return null;
  }, [restoredTabIndex]);

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
            sheet.lastSyncedTabIndex = i;
            if (tabController.index != i) {
              tabController.animateTo(i);
            }
          }
          break;
        }
      }
    }

    scrollController.addListener(onScroll);
    sheet.lastSyncedTabIndex = selectedTabIndex.value;
    return () => scrollController.removeListener(onScroll);
  }, [scrollController, sectionKeys]);

  final onTabTap = useCallback((int index) async {
    final ctx = sectionKeys[index].currentContext;
    if (ctx == null) {
      return;
    }

    final scrollingToLowerSection = index > selectedTabIndex.value;
    isScrollingToTab.value = true;
    selectedTabIndex.value = index;
    sheet.lastSyncedTabIndex = index;

    await ref.read(bottomSheetPixelsProvider.notifier).expandSheet();
    if (!ctx.mounted) {
      isScrollingToTab.value = false;
      return;
    }

    await Scrollable.ensureVisible(ctx, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);

    // ensureVisible overshoots when jumping down through sections; snap once more
    // after layout settles. alignment: 0 keeps the section at the top without the
    // extra downward nudge that 0.08 caused.
    if (scrollingToLowerSection && ctx.mounted) {
      await Future<void>.delayed(const Duration(milliseconds: 50));
      if (ctx.mounted) {
        await Scrollable.ensureVisible(ctx);
      }
    }

    isScrollingToTab.value = false;
  }, [sectionKeys, ref]);

  return (selectedTabIndex: selectedTabIndex, onTabTap: onTabTap);
}
