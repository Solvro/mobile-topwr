import "package:collection/collection.dart";
import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../../../api_base_rest/client/json.dart";
import "../../../../../api_base_rest/translations/translate.dart";
import "../../../../../config/env.dart";

import "../../../../utils/contains_lower_case.dart";
import "../../presentation/calendar_view.dart";
import "../model/calendar_data.dart";
part "calendar_repository.g.dart";

@riverpod
Future<IList<CalendarData>> calendarRepository(Ref ref, String? query) async {
  final apiUrl = Env.mainRestApiUrl;
  final calendarResponse = await ref
      .getAndCacheDataWithTranslation(
        "$apiUrl/event_calendar",
        CalendarDataResponse.fromJson,
        extraValidityCheck: (_) => true,
        localizedOfflineMessage: CalendarView.localizedOfflineMessage,
        onRetry: ref.invalidateSelf,
      )
      .castAsObject;

  return calendarResponse.data
      .where((data) => query == null || data.name.containsLowerCase(query))
      .sortedBy((data) => DateTime.parse(data.startTime))
      .toIList();
}
