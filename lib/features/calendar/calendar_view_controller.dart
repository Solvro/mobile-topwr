import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../utils/contains_lower_case.dart";
import "model/calendar_data.dart";
import "repository/calendar_repository.dart";

part "calendar_view_controller.g.dart";

@Riverpod(dependencies: [])
class SearchCalendarController extends _$SearchCalendarController {
  @override
  String build() => "";

  void onTextChanged(String newValue) {
    state = newValue;
  }
}

@Riverpod(dependencies: [SearchCalendarController])
Future<IList<CalendarData>> calendarListController(Ref ref) async {
  final originalList = await ref.watch(calendarRepositoryProvider.future);
  final query = ref.watch(searchCalendarControllerProvider);
  return originalList.where((element) => element.name.containsLowerCase(query)).toIList();
}
