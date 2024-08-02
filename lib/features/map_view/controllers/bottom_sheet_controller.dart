import "package:flutter/material.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

part "bottom_sheet_controller.g.dart";

@riverpod
DraggableScrollableController bottomSheetController(
  BottomSheetControllerRef ref,
) =>
    DraggableScrollableController();

extension SafeDraggableScrollableControllerWrapperX
    on DraggableScrollableController {
  void resetSafe() {
    if (isAttached) reset();
  }

  double get pixelsSafe => isAttached ? pixels : 0;
}

@riverpod
class BottomSheetPixels extends _$BottomSheetPixels {
  @override
  double build() {
    final controller = ref.watch(bottomSheetControllerProvider);
    controller.addListener(_update);
    ref.onDispose(() {
      controller.removeListener(_update);
    });
    return controller.pixelsSafe;
  }

  void _update() {
    Future.microtask(
      () => state = ref.read(bottomSheetControllerProvider).pixelsSafe,
    );
  }

  Future<void> onSearchBoxTap() async {
    const fullScreenFrac = 1.0;
    final controller = ref.read(bottomSheetControllerProvider);
    if (controller.isAttached && controller.size < fullScreenFrac) {
      await controller.animateTo(
        fullScreenFrac,
        duration: Durations.medium2,
        curve: Curves.decelerate,
      );
    }
  }
}
