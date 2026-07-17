import "package:flutter/scheduler.dart";
import "package:flutter/widgets.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";

import "../../map_view/controllers/bottom_sheet_controller.dart";
import "../../map_view/controllers/controllers_set.dart";
import "../../map_view/widgets/map_config.dart";

/// Preserves the sheet's expansion and list scroll offset across marker activation.
///
/// Activating a marker collapses the list to a single tile and `resetSafe` snaps
/// the sheet to its recommended size. This hook captures both values at the
/// moment of activation (synchronously, before `resetSafe()` runs) and restores
/// them once the marker is deactivated.
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
      _restore(sheet, scrollController);
    }
  });
}

void _capture(DraggableScrollableController sheet, ScrollController scrollController) {
  if (scrollController.hasClients && sheet.isAttached) {
    sheet.preservedPosition = (scrollOffset: scrollController.offset, sheetSize: sheet.size);
  }
}

void _restore(DraggableScrollableController sheet, ScrollController scrollController) {
  final position = sheet.preservedPosition;
  sheet.clearPreservedPosition();
  if (position == null) {
    return;
  }

  var attempts = 0;
  void restore() {
    if (attempts++ > 12) {
      return;
    }

    if (sheet.isAttached) {
      final targetSheet = position.sheetSize.clamp(0.0, 1.0);
      if ((sheet.size - targetSheet).abs() > 0.001) {
        sheet.jumpToSafe(targetSheet);
      }
    }

    if (position.scrollOffset <= 0) {
      return;
    }

    if (!scrollController.hasClients) {
      SchedulerBinding.instance.addPostFrameCallback((_) => restore());
      return;
    }

    final maxExtent = scrollController.position.maxScrollExtent;
    final targetOffset = position.scrollOffset.clamp(0.0, maxExtent);
    if ((scrollController.offset - targetOffset).abs() > 0.5) {
      scrollController.jumpTo(targetOffset);
    }

    // Full list may still be laying out after async map-data reload.
    if (maxExtent < position.scrollOffset) {
      SchedulerBinding.instance.addPostFrameCallback((_) => restore());
    }
  }

  SchedulerBinding.instance.addPostFrameCallback((_) => restore());
}
