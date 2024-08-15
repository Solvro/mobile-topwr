import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../utils/where_non_null_iterable.dart";
import "../departments_view/repository/departments_repository.dart";
import "model/sci_club_type.dart";
import "repository/tags_repository.dart";

part "filters_search_controller.g.dart";

@riverpod
class SearchFiltersController extends _$SearchFiltersController {
  @override
  String build() => "";

  void onTextChanged(String newValue) {
    state = newValue;
  }
}

@riverpod
IList<ScienceClubType> typeFiltersFiltered(TypeFiltersFilteredRef ref) {
  final query = ref.watch(searchFiltersControllerProvider);
  return ScienceClubType.values
      .where(
        (x) =>
            x.name.toLowerCase().contains(query.toLowerCase()) ||
            ref
                .sciClubTypeDisplayName(x)
                .toLowerCase()
                .contains(query.toLowerCase()),
      )
      .toIList();
}

@riverpod
Future<IList<Department>> departmentFiltersFiltered(
  DepartmentFiltersFilteredRef ref,
) async {
  final query = ref.watch(searchFiltersControllerProvider);
  final depts = await ref.watch(departmentsRepositoryProvider.future);
  return depts.whereNonNull
      .where(
        (x) =>
            x.name.toLowerCase().contains(query.toLowerCase()) ||
            x.code.toLowerCase().contains(query.toLowerCase()) ||
            (x.betterCode?.toLowerCase().contains(query.toLowerCase()) ??
                false),
      )
      .toIList();
}

@riverpod
Future<IList<Tag>> tagFiltersFiltered(
  TagFiltersFilteredRef ref,
) async {
  final query = ref.watch(searchFiltersControllerProvider);
  final tags = await ref.watch(tagsRepositoryProvider.future);
  return tags.whereNonNull
      .where((x) => x.name.toLowerCase().contains(query.toLowerCase()))
      .toIList();
}
