import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../departments_view/repository/departments_repository.dart";

part "selected_department.g.dart";

@riverpod
class SelectedDepartmentController extends _$SelectedDepartmentController {
  @override
  ISet<Department> build() {
    return const ISet.empty();
  }

  void toggleDepartment(Department newValue) {
    state = state.toggle(newValue);
  }

  void clear() {
    state = state.clear();
  }
}
