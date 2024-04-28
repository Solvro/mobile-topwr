import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../shared_repositories/departments_repository/departments_repository.dart';

part 'departments_tab_controller.g.dart';

@riverpod
class SearchDepartmentsController extends _$SearchDepartmentsController {
  @override
  String build() => "";

  void onTextChanged(String newValue) {
    state = newValue;
  }
}

@riverpod
Future<List<Department?>?> departmentList(DepartmentListRef ref) async {
  final originalList = await ref.watch(departmentsRepositoryProvider.future);
  final query = ref.watch(searchDepartmentsControllerProvider);
  return originalList
      ?.where((element) =>
          element == null ||
          element.name.toLowerCase().contains(query.toLowerCase()) ||
          element.code.toLowerCase().contains(query.toLowerCase()))
      .toList();
}
