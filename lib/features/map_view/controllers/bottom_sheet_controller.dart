import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../utils/unwaited_microtask.dart";

part "bottom_sheet_controller.g.dart";

@Riverpod(dependencies: [])
Raw<DraggableScrollableController> bottomSheetController(Ref ref) => DraggableScrollableController();

extension SafeDraggableScrollableControllerWrapperX on DraggableScrollableController {
  void resetSafe() {
    if (isAttached) reset();
  }

  double get pixelsSafe => isAttached ? pixels : 0;
}

@Riverpod(dependencies: [bottomSheetController])
class BottomSheetPixels extends _$BottomSheetPixels {
  final _fullScreenFraction = 1.0;
  // These values don't really matter much, they will be updated on sheet build via updateFractions
  var _recommendedFraction = 0.5;
  var _minFraction = 0.2;

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
    unwaitedMicrotask(() async => state = ref.read(bottomSheetControllerProvider).pixelsSafe);
  }

  void updateFractions({required double recommendedFraction, required double minFraction}) {
    _recommendedFraction = recommendedFraction;
    _minFraction = minFraction;
  }

  Future<void> expandSheet() async {
    final controller = ref.read(bottomSheetControllerProvider);
    if (controller.isAttached && controller.size < _fullScreenFraction) {
      await controller.animateTo(_fullScreenFraction, duration: Durations.medium2, curve: Curves.decelerate);
    }
  }

  Future<void> hideSheet() async {
    final controller = ref.read(bottomSheetControllerProvider);
    if (controller.isAttached && controller.size > _minFraction) {
      await controller.animateTo(_minFraction, duration: Durations.medium2, curve: Curves.decelerate);
    }
  }

  Future<void> setRecommendedSheetSize() async {
    final controller = ref.read(bottomSheetControllerProvider);
    if (controller.isAttached && controller.size != _recommendedFraction) {
      await controller.animateTo(_recommendedFraction, duration: Durations.medium2, curve: Curves.decelerate);
    }
  }
}
