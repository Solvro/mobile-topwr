import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../utils/where_non_null_iterable.dart";
import "../../science_clubs_filters/departments/controller/selected_department.dart";
import "../../science_clubs_filters/tags/controller/selected_tag_controller.dart";
import "../../science_clubs_filters/types/controller/selected_type.dart";
import "../repositories/science_clubs/science_clubs_repository.dart";

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
bool areFiltersEnabled(AreFiltersEnabledRef ref) {
  final selectedTags = ref.watch(selectedTagControllerProvider);
  final selectedDepartments = ref.watch(selectedDepartmentControllerProvider);
  final selectedTypes = ref.watch(selectedTypeControllerProvider);
  return selectedTags.isNotEmpty ||
      selectedDepartments.isNotEmpty ||
      selectedTypes.isNotEmpty;
}

@riverpod
Future<Iterable<ScienceClub?>?> scienceClubsList(
  ScienceClubsListRef ref,
) async {
  final sciClubs =
      (await ref.watch(_sciClubsFilteredByTextQueryProvider.future))
          .whereNonNull;

  if (!ref.watch(areFiltersEnabledProvider)) {
    return sciClubs;
  }

  final selectedTags =
      ref.watch(selectedTagControllerProvider).map((element) => element.name);

  final selectedDepartments = ref
      .watch(selectedDepartmentControllerProvider)
      .map((element) => element.name);

  final selectedTypes = ref
      .watch(selectedTypeControllerProvider)
      .map((element) => element.toJson());

  final filteredByTypes = selectedTypes.isEmpty
      ? sciClubs
      : sciClubs.where(
          (club) => selectedTypes.contains(club.type ?? ""),
        );

  final filteredByDepartments = selectedDepartments.isEmpty
      ? filteredByTypes
      : filteredByTypes.where(
          (club) {
            return selectedDepartments.contains(club.department?.name);
          },
        );

  final filterByTags = selectedTags.isEmpty
      ? filteredByDepartments
      : filteredByDepartments.where(
          (club) =>
              club.tags
                  ?.any((tag) => selectedTags.contains(tag?.Tags_id?.name)) ??
              false,
        );

  return filterByTags;
}
