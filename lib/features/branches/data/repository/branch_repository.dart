import "package:clarity_flutter/clarity_flutter.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../../config/shared_prefs.dart";
import "../model/branch.dart";

part "branch_repository.g.dart";

const _key = "selected_branch";

@riverpod
class BranchRepository extends _$BranchRepository {
  @override
  Future<Branch?> build() async {
    final sharedPrefs = await ref.watch(sharedPreferencesSingletonProvider.future);

    final branchName = sharedPrefs.getString(_key);
    final branch = Branch.fromNameOrNull(branchName);
    Clarity.setCustomTags("branch", [branch?.name ?? ""]);
    return branch;
  }

  Future<void> setBranch(Branch branch) async {
    final sharedPrefs = await ref.watch(sharedPreferencesSingletonProvider.future);

    await sharedPrefs.setString(_key, branch.name);
    Clarity.setCustomTags("branch", [branch.name]);
    state = AsyncValue.data(branch);
  }
}
