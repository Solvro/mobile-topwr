import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../../utils/contains_lower_case.dart";
import "../../../../utils/where_non_null_iterable.dart";
import "../../science_clubs_filters/filters_controller.dart";
import "../repository/science_clubs_repository.dart";

part "science_clubs_view_controller.g.dart";

@Riverpod(dependencies: [])
class SearchScienceClubsController extends _$SearchScienceClubsController {
  @override
  String build() => "";

  void onTextChanged(String newValue) {
    state = newValue;
  }
}

@Riverpod(dependencies: [SearchScienceClubsController])
Future<Iterable<ScienceClub>> _sciClubsFilteredByTextQuery(Ref ref) async {
  final originalList = await ref.watch(scienceClubsRepositoryProvider.future);
  final query = ref.watch(searchScienceClubsControllerProvider);
  return originalList.where(
    (element) =>
        element.name.containsLowerCase(query) ||
        (element.department?.name).containsLowerCase(query) ||
        (element.department?.code).containsLowerCase(query) ||
        (element.department?.betterCode).containsLowerCase(query),
  );
}

@Riverpod(
  dependencies: [
    _sciClubsFilteredByTextQuery,
    areFiltersEnabled,
    SelectedTagController,
    SelectedDepartmentController,
    SelectedTypeController,
  ],
)
Future<IList<ScienceClub>> scienceClubsListController(Ref ref) async {
  final sciClubs = (await ref.watch(_sciClubsFilteredByTextQueryProvider.future)).whereNonNull;

  if (!ref.watch(areFiltersEnabledProvider)) {
    return sciClubs.toIList();
  }

  final selectedTags = ref.watch(selectedTagControllerProvider).map((it) => it.name);

  final selectedDepartments = ref.watch(selectedDepartmentControllerProvider).map((it) => it.name);

  final selectedTypes = ref.watch(selectedTypeControllerProvider).map((it) => it.toJson());

  final filteredByTypes =
      selectedTypes.isEmpty ? sciClubs : sciClubs.where((club) => selectedTypes.contains(club.type));

  final filteredByDepartments =
      selectedDepartments.isEmpty
          ? filteredByTypes
          : filteredByTypes.where((club) => selectedDepartments.contains(club.department?.name));

  final filteredByTags =
      selectedTags.isEmpty
          ? filteredByDepartments
          : filteredByDepartments.where(
            (club) => club.tags.whereNonNull.any((tag) => selectedTags.contains(tag.Tags_id?.name)),
          );

  return filteredByTags.toIList();
}
