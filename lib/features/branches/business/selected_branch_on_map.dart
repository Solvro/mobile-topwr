import "package:riverpod_annotation/riverpod_annotation.dart";

import "../data/model/branch.dart";
import "../data/repository/branch_repository.dart";

part "selected_branch_on_map.g.dart";

@riverpod
class SelectedBranchOnMap extends _$SelectedBranchOnMap {
  @override
  Branch? build() {
    return ref.watch(branchRepositoryProvider).value ?? Branch.main;
  }

  void setBranch(Branch branch) {
    state = branch;
  }
}
