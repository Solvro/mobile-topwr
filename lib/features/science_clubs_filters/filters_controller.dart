// ignore_for_file: unnecessary_overrides

import "dart:ui";

import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../departments_view/repository/departments_repository.dart";
import "model/sci_club_type.dart";
import "repository/tags_repository.dart";

part "filters_controller.g.dart";

mixin FilterController<T> on AutoDisposeNotifier<ISet<T>> {
  @override
  ISet<T> build() {
    return const ISet.empty();
  }

  void toggleFilter(T val) {
    state = state.toggle(val);
  }

  void clearFilter() {
    state = state.clear();
  }
}

@riverpod
class SelectedDepartmentController extends _$SelectedDepartmentController
    with FilterController<Department> {
  @override
  ISet<Department> build() => const ISet.empty();
}

@riverpod
class SelectedTagController extends _$SelectedTagController
    with FilterController<Tag> {
  @override
  ISet<Tag> build() => const ISet.empty();
}

@riverpod
class SelectedTypeController extends _$SelectedTypeController
    with FilterController<ScienceClubType> {
  @override
  ISet<ScienceClubType> build() => const ISet.empty();
}

@riverpod
bool areFiltersEnabled(AreFiltersEnabledRef ref) {
  final selectedTags = ref.watch(selectedTagControllerProvider);
  final selectedDepartments = ref.watch(selectedDepartmentControllerProvider);
  final selectedTypes = ref.watch(selectedTypeControllerProvider);
  return selectedTags.isNotEmpty ||
      selectedDepartments.isNotEmpty ||
      selectedTypes.isNotEmpty;
}

typedef FilterControllerProvider<T>
    = AutoDisposeNotifierProvider<FilterController<T>, ISet<T>>;

extension SliceStateX on WidgetRef {
  bool watchContains<T>(
    FilterControllerProvider<T> selectedProvider,
    T valueToCheck,
  ) =>
      watch(
        selectedProvider.select(
          (value) => value.contains(valueToCheck),
        ),
      );

  VoidCallback getClearAllFilters(WidgetRef ref) {
    return () {
      ref.read(selectedTagControllerProvider.notifier).clearFilter();
      ref.read(selectedDepartmentControllerProvider.notifier).clearFilter();
      ref.read(selectedTypeControllerProvider.notifier).clearFilter();
    };
  }
}
