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
            x.localize(l10n).toLowerCase().contains(query.toLowerCase()),
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

@Riverpod(dependencies: [typeFiltersFiltered, departmentFiltersFiltered, tagFiltersFiltered])
bool areNoFiltersFound(Ref ref) {
  final source1Empty = !ref.watch(typeFiltersFilteredProvider.select((value) => value.isNotEmpty));
  final source2Empty =
      !(ref.watch(departmentFiltersFilteredProvider.select((value) => value.value?.isNotEmpty ?? false)) ?? false);
  final source3Empty =
      !(ref.watch(tagFiltersFilteredProvider.select((value) => value.value?.isNotEmpty ?? false)) ?? false);

  return source1Empty && source2Empty && source3Empty;
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
  final branchesAsync = ref.watch(branchFiltersFilteredProvider(l10n));
  final departmentsAsync = ref.watch(departmentFiltersFilteredProvider);

  final selectedBranches = ref.watch(selectedBranchControllerProvider);
  final selectedDepartments = ref.watch(selectedDepartmentControllerProvider);

  final branches = branchesAsync.when(data: (b) => b, loading: IList<Branch>.new, error: (_, _) => IList<Branch>());

  final departments = departmentsAsync.when(
    data: (d) => d,
    loading: IList<Department>.new,
    error: (_, _) => IList<Department>(),
  );

  final branchesToShow = selectedDepartments.isEmpty ? branches : IList<Branch>();
  final departmentsToShow = (selectedBranches.isEmpty || selectedBranches.contains(Branch.main))
      ? departments
      : IList<Department>();

  return (branches: branchesToShow, departments: departmentsToShow);
}
