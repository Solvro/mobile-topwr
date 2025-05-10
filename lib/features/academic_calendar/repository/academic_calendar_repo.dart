import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";
import "../../../api_base_rest/cache/cache.dart";
import "../../../config/env.dart";
import "../../../config/ttl_config.dart";
import "../model/academic_calendar_rest_model.dart";
import "../model/day_swap_rest_model.dart";
import "../widgets/home_screen_greeting.dart";

part "academic_calendar_repo.g.dart";

class AcademicCalendarData {
  final AcademicCalendarRestData calendarData;
  final IList<DaySwapRestData> daySwaps;

  AcademicCalendarData({required this.calendarData, required this.daySwaps});
}

@riverpod
Future<AcademicCalendarData?> academicCalendarRepo(Ref ref) async {
  final apiUrl = Env.mainRestApiUrl;
  const academicCalendarEndpoint = "/academic_calendars";
  const daySwapsEndpoint = "/day_swaps";

  final responses = await Future.wait([
    ref.getAndCacheData(
      apiUrl + academicCalendarEndpoint,
      TtlStrategy.get(TtlKey.academicCalendarRepository).inDays,
      AcademicCalendarRestResponse.fromJson,
      extraValidityCheck: (_) => true,
      localizedOfflineMessage: Greeting.localizedOfflineMessage,
      onRetry: ref.invalidateSelf,
    ),
    ref.getAndCacheData(
      apiUrl + daySwapsEndpoint,
      TtlStrategy.get(TtlKey.academicCalendarRepository).inDays,
      DaySwapRestResponse.fromJson,
      extraValidityCheck: (_) => true,
      localizedOfflineMessage: Greeting.localizedOfflineMessage,
      onRetry: ref.invalidateSelf,
    ),
  ]);
  final calendarData = responses[0] as AcademicCalendarRestResponse;
  final daySwaps = responses[1] as DaySwapRestResponse;

  return AcademicCalendarData(calendarData: calendarData.data.first, daySwaps: daySwaps.data.toIList());
}

extension FixNestedTypesX on AcademicCalendarData {
  AcademicCalendarRestData get data => calendarData;
  IList<DaySwapRestData> get weeks => daySwaps;
}
