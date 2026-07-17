import "dart:async";

import "package:flutter/scheduler.dart";
import "package:flutter/widgets.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";

import "../../map_view/controllers/bottom_sheet_controller.dart";
import "../../map_view/controllers/controllers_set.dart";
import "../../map_view/widgets/map_config.dart";
import "../../parkings/parkings_view/models/parking.dart";

/// Preserves the sheet's expansion and list scroll offset across marker activation.
///
/// Activating a marker collapses the list to a single tile and `resetSafe` snaps
/// the sheet to its recommended size. This hook captures both values at the
/// moment of activation (synchronously, before `resetSafe()` runs) and restores
/// them once the marker is deactivated.
///
/// Sheet-size restore is animated only for parkings; multilayer jumps instantly.
void usePreservedSheetPosition<T extends GoogleNavigable>(
  BuildContext context,
  WidgetRef ref, {
  required ScrollController scrollController,
}) {
  ref.listen(context.activeMarkerController<T>(), (previous, next) {
    final sheet = ref.read(bottomSheetControllerProvider);

    if (previous == null && next != null) {
      _capture(sheet, scrollController);
      return;
    }

    if (previous != null && next == null) {
      _restore(sheet, scrollController, animateSheet: T == Parking);
    }
  });
}

void _capture(DraggableScrollableController sheet, ScrollController scrollController) {
  if (!scrollController.hasClients) {
    return;
  }

  sheet.preservedPosition = (
    scrollOffset: scrollController.offset,
    sheetSize: sheet.isAttached ? sheet.size : null,
    tabIndex: sheet.lastSyncedTabIndex,
  );
  // Drop to 0 before the short active-item content mounts, so layout does not
  // clamp a large offset a frame later and visually jump.
  scrollController.jumpTo(0);
}

void _restore(DraggableScrollableController sheet, ScrollController scrollController, {required bool animateSheet}) {
  final position = sheet.preservedPosition;
  sheet.clearPreservedPosition();
  if (position == null) {
    return;
  }

  // Consumed when SliverMultiTabberBuilder remounts — survives until then.
  sheet.pendingTabIndex = position.tabIndex;

  var sheetAttachmentAttempts = 0;
  var scrollAttempts = 0;

  void schedule(Future<void> Function() callback) {
    SchedulerBinding.instance.addPostFrameCallback((_) => unawaited(callback()));
  }

  Future<void> restoreScroll() async {
    if (scrollAttempts++ > 12) {
      return;
    }

    if (position.scrollOffset <= 0) {
      return;
    }

    if (!scrollController.hasClients) {
      schedule(restoreScroll);
      return;
    }

    final maxExtent = scrollController.position.maxScrollExtent;
    final targetOffset = position.scrollOffset.clamp(0.0, maxExtent);
    if ((scrollController.offset - targetOffset).abs() > 0.5) {
      scrollController.jumpTo(targetOffset);
    }

    // Full list may still be laying out after async map-data reload.
    if (maxExtent < position.scrollOffset) {
      schedule(restoreScroll);
    }
  }

  Future<void> restore() async {
    final sheetSize = position.sheetSize;
    if (sheetSize != null) {
      if (!sheet.isAttached) {
        if (sheetAttachmentAttempts++ <= 12) {
          schedule(restore);
        }
        return;
      }

      final targetSheet = sheetSize.clamp(0.0, 1.0);
      if ((sheet.size - targetSheet).abs() > 0.001) {
        if (animateSheet) {
          await sheet.animateToSafe(targetSheet);
        } else {
          sheet.jumpToSafe(targetSheet);
        }
      }
    }

    await restoreScroll();
  }

  schedule(restore);
}
