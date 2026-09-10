import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";
import "../../../api_base_rest/cache/cache.dart";
import "../../../api_base_rest/client/json.dart";
import "../../../config/env.dart";
import "../model/academic_calendar.dart";
import "../model/day_swap_model.dart";
import "../utils/select_academic_calendar.dart";

part "academic_calendar_repo.g.dart";

// TODO(simon-the-shark): refactor this
class AcademicCalendarWithSwaps {
  final AcademicCalendar calendarData;
  final IList<DaySwapData> daySwaps;

  AcademicCalendarWithSwaps({required this.calendarData, required this.daySwaps});
}

@riverpod
Future<AcademicCalendarWithSwaps?> academicCalendarRepo(Ref ref) async {
  final apiUrl = Env.mainRestApiUrl;
  const academicCalendarEndpoint = "/academic_calendars";
  const daySwapsEndpoint = "/day_swaps";

  final responses = await Future.wait([
    ref.getAndCacheData(
      apiUrl + academicCalendarEndpoint,
      AcademicCalendarResponse.fromJson,
      extraValidityCheck: (response) => response.castAsObject.data.hasCurrentOrUpcoming(),
      onRetry: ref.invalidateSelf,
    ),
    ref.getAndCacheData(
      apiUrl + daySwapsEndpoint,
      DaySwapResponse.fromJson,
      extraValidityCheck: (response) => response.castAsObject.data.hasUpcomingOrToday(),
      onRetry: ref.invalidateSelf,
    ),
  ]);
  final calendarData = responses[0].castAsObject as AcademicCalendarResponse;
  final daySwaps = responses[1].castAsObject as DaySwapResponse;

  final selectedCalendar = calendarData.data.selectCurrentOrUpcoming();
  if (selectedCalendar == null) {
    return null;
  }

  return AcademicCalendarWithSwaps(
    calendarData: selectedCalendar,
    daySwaps: daySwaps.data.forAcademicCalendar(selectedCalendar.id).toIList(),
  );
}

extension FixNestedTypesX on AcademicCalendarWithSwaps {
  AcademicCalendar get data => calendarData;
  IList<DaySwapData> get weeks => daySwaps;
}
