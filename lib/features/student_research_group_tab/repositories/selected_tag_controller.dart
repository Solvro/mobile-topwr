import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'tags_repository.dart';

part 'selected_tag_controller.g.dart';

@riverpod
class SelectedTagController extends _$SelectedTagController {
  @override
  String? build() {
    return null;
  }

  void handleTagSelected(Tag newValue) {
    state = newValue.name;
  }
}
