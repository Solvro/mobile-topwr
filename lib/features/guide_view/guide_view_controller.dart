import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../utils/contains_lower_case.dart";
import "data/models/guide_data.dart";
import "data/repository/guide_repository.dart";

part "guide_view_controller.g.dart";

@Riverpod(dependencies: [])
class SearchGuideController extends _$SearchGuideController {
  @override
  String build() => "";

  void onTextChanged(String newValue) {
    state = newValue;
  }
}

@Riverpod(dependencies: [SearchGuideController])
Future<IList<GuideData>> guideListController(Ref ref) async {
  final originalList = await ref.watch(guideRepositoryProvider.future);
  final query = ref.watch(searchGuideControllerProvider);
  return originalList.where((element) => element.title.containsLowerCase(query)).toIList();
}
