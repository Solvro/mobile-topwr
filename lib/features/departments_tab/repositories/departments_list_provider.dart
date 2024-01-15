import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'departments_repository.dart';
import 'getDepartments.graphql.dart';
import 'search_provider.dart';

part 'departments_list_provider.g.dart';

@riverpod
AsyncValue<List<Department?>> departmentList(DepartmentListRef ref) {
  final originalList = ref.watch(departmentsRepositoryProvider);
  final query = ref.watch(searchTextControllerProvider);
  if (originalList.runtimeType == AsyncLoading<List<Query$GetDepartments$departments?>?>) {
    return const AsyncValue.loading();
  }
  return originalList.when(
    data: (data) {
      try {
        final filteredList = originalList.value!
            .where((element) =>
                element!.name.toLowerCase().contains(query.toLowerCase()) ||
                element.code.toLowerCase().contains(query.toLowerCase()))
            .toList();
        return AsyncValue.data(filteredList);
      } catch (error) {
        return AsyncValue.error(error, StackTrace.current); 
      }
    },
    error: (error, __) => AsyncValue.error(error, __), 
    loading: () => const AsyncValue.loading(), 
  );
}
