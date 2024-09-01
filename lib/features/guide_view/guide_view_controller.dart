import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../utils/contains_lower_case.dart";
import "repository/guide_repository.dart";

part "guide_view_controller.g.dart";

@riverpod
class SearchGuideController extends _$SearchGuideController {
  @override
  String build() => "";

  void onTextChanged(String newValue) {
    state = newValue;
  }
}

@riverpod
bool isSomethingSearched(IsSomethingSearchedRef ref) {
  return ref.watch(searchGuideControllerProvider) != "";
}

@riverpod
Future<IList<GuidePost>> guideListController(
  GuideListControllerRef ref,
) async {
  final originalList = await ref.watch(guideRepositoryProvider.future);
  final query = ref.watch(searchGuideControllerProvider);
  return originalList
      .where(
        (element) => element.name.containsLowerCase(query),
      )
      .toIList();
}
