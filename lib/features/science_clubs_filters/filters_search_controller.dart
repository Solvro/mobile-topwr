import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../utils/contains_lower_case.dart";
import "../departments_view/repository/departments_repository.dart";
import "model/sci_club_type.dart";
import "repository/tags_repository.dart";
import "utils.dart";

part "filters_search_controller.g.dart";

@Riverpod(dependencies: [])
class SearchFiltersController extends _$SearchFiltersController {
  @override
  String build() => "";

  void onTextChanged(String newValue) {
    state = newValue;
  }

  void clear() {
    state = "";
  }
}

@Riverpod(dependencies: [SearchFiltersController])
IList<ScienceClubType> typeFiltersFiltered(Ref ref) {
  final query = ref.watch(searchFiltersControllerProvider);
  return ScienceClubType.values
      .where(
        (x) =>
            x.name.containsLowerCase(query) ||
            ref
                .sciClubTypeDisplayName(x)
                .toLowerCase()
                .contains(query.toLowerCase()),
      )
      .toIList();
}

@Riverpod(dependencies: [SearchFiltersController])
Future<IList<Department>> departmentFiltersFiltered(
  Ref ref,
) async {
  final query = ref.watch(searchFiltersControllerProvider);
  final depts = await ref.watch(departmentsRepositoryProvider.future);
  return depts
      .where(
        (x) =>
            x.name.containsLowerCase(query) ||
            x.code.containsLowerCase(query) ||
            x.betterCode.containsLowerCase(query),
      )
      .toIList();
}

@Riverpod(dependencies: [SearchFiltersController])
Future<IList<Tag>> tagFiltersFiltered(Ref ref) async {
  final query = ref.watch(searchFiltersControllerProvider);
  final tags = await ref.watch(tagsRepositoryProvider.future);
  return tags.where((x) => x.name.containsLowerCase(query)).toIList();
}

@Riverpod(
  dependencies: [
    typeFiltersFiltered,
    departmentFiltersFiltered,
    tagFiltersFiltered,
  ],
)
bool areNoFiltersFound(Ref ref) {
  final source1Empty = !ref.watch(typeFiltersFilteredProvider.notEmpty);
  final source2Empty =
      !(ref.watch(departmentFiltersFilteredProvider.notEmpty) ?? false);
  final source3Empty =
      !(ref.watch(tagFiltersFilteredProvider.notEmpty) ?? false);

  return source1Empty && source2Empty && source3Empty;
}
