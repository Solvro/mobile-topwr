import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../repositories/scientific_circles/scientific_circles_repository.dart';

part 'student_research_group_tab_controller.g.dart';

@riverpod
class SearchScientificCirclesController extends _$SearchScientificCirclesController {
  @override
  String build() => "";

  void onTextChanged(String newValue) {
    state = newValue;
  }
}

@riverpod
AsyncValue<List<ScientificCircle?>?> scientificCircleList(ScientificCircleListRef ref) {
  final originalList = ref.watch(scientificCirclesRepositoryProvider);
  final query = ref.watch(searchScientificCirclesControllerProvider);
  if (originalList.isLoading) return const AsyncLoading();
  return originalList.whenData((value) {
    return value
        ?.where((element) =>
        element == null ||
        element.name.toLowerCase().contains(query.toLowerCase()) ||
        element.description.toLowerCase().contains(query.toLowerCase()))
    .toList();
  });
}
