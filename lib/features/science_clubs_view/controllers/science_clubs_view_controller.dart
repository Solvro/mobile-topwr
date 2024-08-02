import "package:riverpod_annotation/riverpod_annotation.dart";

import "../repositories/science_clubs/science_clubs_repository.dart";

import "../repositories/tags/tags_repository.dart";
import "selected_tag_controller.dart";

part "science_clubs_view_controller.g.dart";

@riverpod
class SearchScienceClubsController extends _$SearchScienceClubsController {
  @override
  String build() => "";

  void onTextChanged(String newValue) {
    state = newValue;
  }
}

@riverpod
Future<Iterable<ScienceClub?>?> _sciClubsFilteredByTextQuery(
  _SciClubsFilteredByTextQueryRef ref,
) async {
  final originalList = await ref.watch(scienceClubsRepositoryProvider.future);
  final query = ref.watch(searchScienceClubsControllerProvider);
  return originalList?.where(
    (element) =>
        element == null ||
        element.name.toLowerCase().contains(query.toLowerCase()) ||
        (element.department?.name.toLowerCase().contains(query.toLowerCase()) ??
            false),
  );
}

@riverpod
Future<Iterable<ScienceClub?>?> scienceClubsList(
  ScienceClubsListRef ref,
) async {
  final sciClubs = await ref.watch(_sciClubsFilteredByTextQueryProvider.future);
  final selectedCategory = ref.watch(selectedTagControllerProvider);
  if (selectedCategory == ref.watch(allTagSingletonProvider).name) {
    return sciClubs;
  }
  final filteredAndSelectedTag = sciClubs?.where((circle) {
    return circle?.tags?.any((tag) => tag?.Tags_id?.name == selectedCategory) ??
        false;
  });
  return filteredAndSelectedTag;
}
