import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../model/sci_club_type.dart";

part "selected_type.g.dart";

@riverpod
class SelectedTypeController extends _$SelectedTypeController {
  @override
  ISet<ScienceClubType> build() {
    return const ISet.empty();
  }

  void toggleType(ScienceClubType newValue) {
    state = state.toggle(newValue);
  }

  void clear() {
    state = state.clear();
  }
}
