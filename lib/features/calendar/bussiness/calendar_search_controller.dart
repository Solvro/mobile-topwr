import "package:riverpod_annotation/riverpod_annotation.dart";

part "calendar_search_controller.g.dart";

@riverpod
class SearchCalendarController extends _$SearchCalendarController {
  @override
  String build() => "";

  void onTextChanged(String newValue) {
    state = newValue;
  }
}
