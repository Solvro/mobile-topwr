import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../../../api_base_rest/client/json.dart";
import "../../../../../api_base_rest/translations/translate.dart";
import "../../../../../config/env.dart";
import "../../../../branches/data/model/branch.dart";
import "../../../../branches/data/repository/branch_repository.dart";
import "../../departments_view.dart";
import "../models/department.dart";

part "departments_repository.g.dart";

@riverpod
Future<IList<Department>> departmentsRepository(Ref ref) async {
  final url = "${Env.mainRestApiUrl}/departments";

  final response = await ref
      .getAndCacheDataWithTranslation(
        url,
        DepartmentsResponse.fromJson,
        extraValidityCheck: (_) => true,
        localizedOfflineMessage: DepartmentsView.localizedOfflineMessage,
        onRetry: ref.invalidateSelf,
      )
      .castAsObject;

  return response.data.sortByBranch(await ref.watch(branchRepositoryProvider.future)).toIList();
}

extension SortBySourceTypeX on Iterable<Department> {
  List<Department> sortByBranch(Branch? branch) {
    if (branch == null) return toList();
    final branchDepartments = where((element) => element.branch == branch);
    final otherDepartments = where((element) => element.branch != branch);
    return [...branchDepartments, ...otherDepartments];
  }
}
