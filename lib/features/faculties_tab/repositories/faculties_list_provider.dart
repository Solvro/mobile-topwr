import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../models/faculty_model.dart';
import 'search_provider.dart';

part 'faculties_list_provider.g.dart';

@riverpod
List<FacultyModel> filteredList(FilteredListRef ref) {
  final originalList = Faculties().getFaculties();
  final query = ref.watch(searchTextControllerProvider);
  final filteredList = originalList.where((element)=>
    element.sectionName.toLowerCase().contains(query.toLowerCase()) ||
    element.sectionShortcut.toLowerCase().contains(query.toLowerCase())
  ).toList();
  return filteredList;
}
