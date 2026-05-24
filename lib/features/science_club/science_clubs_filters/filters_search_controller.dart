import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../l10n/app_localizations.dart";
import "../../../utils/contains_lower_case.dart";
import "../../branches/data/model/branch.dart";
import "../../departments/departments_view/data/models/department.dart";
import "../../departments/departments_view/data/repository/departments_repository.dart";
import "../science_clubs_view/model/branch_department_data.dart";
import "filters_controller.dart";
import "model/sci_club_type.dart";
import "model/tags.dart";
import "repository/tags_repository.dart";

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
            ref.sciClubTypeDisplayName(x).toLowerCase().contains(query.toLowerCase()),
      )
      .toIList();
}

@Riverpod(dependencies: [SearchFiltersController])
Future<IList<Branch>> branchFiltersFiltered(Ref ref, AppLocalizations l10n) async {
  final query = ref.watch(searchFiltersControllerProvider);

  return Branch.values
      .where(
        (x) =>
            x.name.containsLowerCase(query.toLowerCase()) ||
            x.localizeFilter(l10n).toLowerCase().contains(query.toLowerCase()),
      )
      .toIList();
}

@Riverpod(dependencies: [SearchFiltersController])
Future<IList<Department>> departmentFiltersFiltered(Ref ref) async {
  final query = ref.watch(searchFiltersControllerProvider);
  final depts = await ref.watch(departmentsRepositoryProvider.future);

  if (query.isEmpty) return depts.toIList();

  return depts
      .where(
        (x) =>
            x.name.containsLowerCase(query) || x.code.containsLowerCase(query) || x.betterCode.containsLowerCase(query),
      )
      .toIList();
}

@Riverpod(dependencies: [SearchFiltersController])
Future<IList<Tag>> tagFiltersFiltered(Ref ref) async {
  final query = ref.watch(searchFiltersControllerProvider);
  final tags = await ref.watch(tagsRepositoryProvider.future);
  return tags.where((x) => x.tag.containsLowerCase(query)).toIList();
}

@Riverpod(
  dependencies: [typeFiltersFiltered, branchDepartmentFilteredHelper, tagFiltersFiltered, branchFiltersFiltered],
)
bool areNoFiltersFound(Ref ref, AppLocalizations l10n) {
  final typeSrcEmpty = !ref.watch(typeFiltersFilteredProvider.select((value) => value.isNotEmpty));
  final departmentSrcEmpty =
      !(ref.watch(
            branchDepartmentFilteredHelperProvider(
              l10n,
            ).select((value) => value.value?.departments.isNotEmpty ?? false),
          ) ??
          false);

  final tagSrcEmpty =
      !(ref.watch(tagFiltersFilteredProvider.select((value) => value.value?.isNotEmpty ?? false)) ?? false);

  final branchSrcEmpty =
      !(ref.watch(branchFiltersFilteredProvider(l10n).select((value) => value.value?.isNotEmpty ?? false)) ?? false);

  return typeSrcEmpty && departmentSrcEmpty && tagSrcEmpty && branchSrcEmpty;
}

@Riverpod(
  dependencies: [
    SelectedBranchController,
    SelectedDepartmentController,
    branchFiltersFiltered,
    departmentFiltersFiltered,
  ],
)
Future<BranchDepartmentData> branchDepartmentFilteredHelper(Ref ref, AppLocalizations l10n) async {
  final branches = await ref.watch(branchFiltersFilteredProvider(l10n).future);
  final departments = await ref.watch(departmentFiltersFilteredProvider.future);
  final selectedBranches = ref.watch(selectedBranchControllerProvider);
  final selectedDepartments = ref.watch(selectedDepartmentControllerProvider);

  final branchesToShow = selectedDepartments.isEmpty ? branches : IList<Branch>();
  final departmentsToShow = (selectedBranches.isEmpty || selectedBranches.contains(Branch.main))
      ? departments.where((d) => d.branch == Branch.main).toIList()
      : IList<Department>();

  return (branches: branchesToShow, departments: departmentsToShow);
}
