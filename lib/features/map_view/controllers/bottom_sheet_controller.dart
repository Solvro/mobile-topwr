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
    return 0;
  }

  void _update() {
    state = ref.read(bottomSheetControllerProvider).pixels;
  }

  void onSearchBoxTap() {
    const fullScreenFrac = 1.0;
    if (ref.read(bottomSheetControllerProvider).size < fullScreenFrac) {
      ref.read(bottomSheetControllerProvider).animateTo(
            fullScreenFrac,
            duration: Durations.medium2,
            curve: Curves.decelerate,
          );
    }
  }
}
