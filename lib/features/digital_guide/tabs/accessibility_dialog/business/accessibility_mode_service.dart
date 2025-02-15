import "dart:async";

import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../data/accessibility_mode_repository.dart";
import "../data/modes.dart";

part "accessibility_mode_service.g.dart";

// if the mode has children, it will be calculated based on them
// if the mode has a key, it will be calculated based on the repository
@riverpod
class AccessibilityModeService extends _$AccessibilityModeService {
  @override
  Future<bool> build(AccessibilityMode mode) async {
    return switch (mode) {
      ModeWithChildren() => _calculateModeWithChildrenState(mode),
      ModeWithKey() => ref.watch(
          accessibilityModeRepositoryProvider(mode).future,
        ),
    };
  }

  Future<void> setMode({required bool newValue}) async {
    final modeStronglyTyped = mode; // needed for typing system
    await switch (modeStronglyTyped) {
      ModeWithChildren() =>
        _setModeWithChildrenState(modeStronglyTyped, newValue),
      ModeWithKey() => _setSingularModeState(modeStronglyTyped, newValue),
    };
  }

  // true if any of its children are true
  Future<bool> _calculateModeWithChildrenState(ModeWithChildren mode) async {
    final submodesValues = await Future.wait(
      mode.children.map(
        (child) => ref.watch(accessibilityModeServiceProvider(child).future),
      ),
    );
    return submodesValues.anyIs(true);
  }

  // sets all childrens' of the mode to newValue
  Future<void> _setModeWithChildrenState(
    ModeWithChildren mode,
    bool newValue,
  ) async {
    for (final child in mode.children) {
      await ref
          .read(accessibilityModeServiceProvider(child).notifier)
          .setMode(newValue: newValue);
    }
  }

  // calls directly the repository
  Future<void> _setSingularModeState(
    ModeWithKey modeStronglyTyped,
    bool newValue,
  ) {
    return ref
        .read(
          accessibilityModeRepositoryProvider(modeStronglyTyped).notifier,
        )
        .setMode(newValue: newValue);
  }
}
