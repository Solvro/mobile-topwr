import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../utils/contains_lower_case.dart";
import "repository/departments_repository.dart";

part "departments_view_controllers.g.dart";

@riverpod
class SearchDepartmentsController extends _$SearchDepartmentsController {
  @override
  String build() => "";

  void onTextChanged(String newValue) {
    state = newValue;
  }
}

@riverpod
Future<List<Department?>?> departmentsList(DepartmentsListRef ref) async {
  final originalList = await ref.watch(departmentsRepositoryProvider.future);
  final query = ref.watch(searchDepartmentsControllerProvider);
  return originalList
      ?.where(
        (element) =>
            element == null ||
            element.name.containsLowerCase(query) ||
            element.code.containsLowerCase(query),
      )
      .toList();
}
