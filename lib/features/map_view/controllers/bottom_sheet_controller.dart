import 'package:flutter/widgets.dart';
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
}
