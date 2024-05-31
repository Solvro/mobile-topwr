import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../shared_repositories/sci_clubs_repository/scientific_circles_repository.dart';
import 'selected_tag_controller.dart';
import 'tags_repository.dart';

part 'scientific_circles_tab_controller.g.dart';

@riverpod
class SearchScientificCirclesController
    extends _$SearchScientificCirclesController {
  @override
  String build() => "";

  void onTextChanged(String newValue) {
    state = newValue;
  }
}

@riverpod
Future<Iterable<ScientificCircle?>?> _sciCirclesFilteredByTextQuery(
    _SciCirclesFilteredByTextQueryRef ref) async {
  final originalList =
      await ref.watch(scientificCirclesRepositoryProvider.future);
  final query = ref.watch(searchScientificCirclesControllerProvider);
  return originalList?.where((element) =>
      element == null ||
      element.name.toLowerCase().contains(query.toLowerCase()) ||
      (element.department?.name.toLowerCase().contains(query.toLowerCase()) ??
          false));
}

@riverpod
Future<Iterable<ScientificCircle?>?> scientificCircleList(
    ScientificCircleListRef ref) async {
  final circles =
      await ref.watch(_sciCirclesFilteredByTextQueryProvider.future);

  final selectedCategory = ref.watch(selectedTagControllerProvider);
  if (selectedCategory == ref.watch(allTagSingletonProvider).name) {
    return circles;
  }

  final filteredAndSelectedTag = circles?.where((circle) {
    return circle?.tags?.any((tag) => tag?.Tags_id?.name == selectedCategory) ??
        false;
  });
  return filteredAndSelectedTag;
}
