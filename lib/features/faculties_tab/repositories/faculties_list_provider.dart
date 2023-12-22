import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../repositories/departments_repository.dart';
import 'search_provider.dart';

part 'faculties_list_provider.g.dart';

@riverpod
List<Department?> filteredList(FilteredListRef ref) {
  final originalList = ref.watch(departmentsRepositoryProvider);
  final query = ref.watch(searchTextControllerProvider);
  final filteredList = originalList.value!.where((element)=>
    element!.name.toLowerCase().contains(query.toLowerCase()) ||
    element.code.toLowerCase().contains(query.toLowerCase())
  ).toList();
  return filteredList;
}
