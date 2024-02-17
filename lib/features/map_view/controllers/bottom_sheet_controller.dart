import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part "bottom_sheet_controller.g.dart";

@riverpod
DraggableScrollableController bottomSheetController(
        BottomSheetControllerRef ref) =>
    DraggableScrollableController();

@riverpod
class BottomSheetPixels extends _$BottomSheetPixels {
  @override
  double build() {
    final controller = ref.watch(bottomSheetControllerProvider);
    controller.addListener(_update);
    ref.onDispose(() {
      controller.removeListener(_update);
    });
    return 0; // controller is not yet attached so 0 as some initial value
  }

  void _update() {
    state = ref.read(bottomSheetControllerProvider).pixels;
  }

  void onSearchBoxTap() {
    const fullScreenFrac = 1.0;
    final controller = ref.read(bottomSheetControllerProvider);
    if (controller.size < fullScreenFrac) {
      controller.animateTo(
        fullScreenFrac,
        duration: Durations.medium2,
        curve: Curves.decelerate,
      );
    }
  }
}
