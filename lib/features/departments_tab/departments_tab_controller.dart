import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../repositories/departments_repository/departments_repository.dart';

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
AsyncValue<List<Department?>?> departmentList(DepartmentListRef ref) {
  final originalList = ref.watch(departmentsRepositoryProvider);
  final query = ref.watch(searchDepartmentsControllerProvider);
  if (originalList.isLoading) return const AsyncLoading();
  return originalList.whenData((value) {
    return value
        ?.where((element) =>
            element == null ||
            element.name.toLowerCase().contains(query.toLowerCase()) ||
            element.code.toLowerCase().contains(query.toLowerCase()))
        .toList();
  });
}
