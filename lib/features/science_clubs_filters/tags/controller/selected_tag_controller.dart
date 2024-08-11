import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../repository/tags_repository.dart";

part "selected_tag_controller.g.dart";

@riverpod
class SelectedTagController extends _$SelectedTagController {
  @override
  ISet<Tag> build() {
    return const ISet.empty();
  }

  void toggleTag(Tag newValue) {
    state = state.toggle(newValue);
  }

  void clear() {
    state = state.clear();
  }
}
