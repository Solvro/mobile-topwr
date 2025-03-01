import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../utils/contains_lower_case.dart";
import "repository/departments_repository.dart";

part "departments_view_controllers.g.dart";

@Riverpod(dependencies: [])
class SearchDepartmentsController extends _$SearchDepartmentsController {
  @override
  String build() => "";

  void onTextChanged(String newValue) {
    state = newValue;
  }
}

@Riverpod(dependencies: [SearchDepartmentsController])
Future<IList<Department>> departmentsList(Ref ref) async {
  final originalList = await ref.watch(departmentsRepositoryProvider.future);
  final query = ref.watch(searchDepartmentsControllerProvider);
  return originalList
      .where((element) => element.name.containsLowerCase(query) || element.code.containsLowerCase(query))
      .toIList();
}
