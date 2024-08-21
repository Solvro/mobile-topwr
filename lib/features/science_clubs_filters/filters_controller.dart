import "dart:ui";

import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../departments_view/repository/departments_repository.dart";
import "filters_search_controller.dart";
import "model/sci_club_type.dart";
import "repository/tags_repository.dart";
import "utils.dart";

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
  final selectedTagsIsNotEmpty =
      ref.watch(selectedTagControllerProvider.notEmpty);
  final selectedDepartmentsIsNotEmpty =
      ref.watch(selectedDepartmentControllerProvider.notEmpty);
  final selectedTypesIsNotEmpty =
      ref.watch(selectedTypeControllerProvider.notEmpty);
  return selectedTagsIsNotEmpty ||
      selectedDepartmentsIsNotEmpty ||
      selectedTypesIsNotEmpty;
}

extension ClearAllFiltersX on WidgetRef {
  VoidCallback getClearAllFilters(WidgetRef ref) {
    return () {
      ref.read(selectedTagControllerProvider.notifier).clearFilter();
      ref.read(selectedDepartmentControllerProvider.notifier).clearFilter();
      ref.read(selectedTypeControllerProvider.notifier).clearFilter();
      ref.read(searchFiltersControllerProvider.notifier).clear();
    };
  }
}
