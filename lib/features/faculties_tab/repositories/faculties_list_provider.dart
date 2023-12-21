import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../models/faculty_model.dart';
import 'search_provider.dart';

final filteredListProvider =
      Provider<List<FacultyModel>>((ref) {
    final List<FacultyModel> originalList = Faculties().getFaculties();
    final query = ref.watch(searchControllerProvider).text.toLowerCase();

    List<FacultyModel> filteredList = originalList
        .where((element) =>
            element.sectionName.toLowerCase().contains(query) ||
            element.sectionShortcut.toLowerCase().contains(query))
        .toList();

    return filteredList;
  });