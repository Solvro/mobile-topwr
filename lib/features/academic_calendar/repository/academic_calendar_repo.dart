
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../../api_base_rest/cache/cache.dart";
import "../../../../config/env.dart";
import "../../../../config/ttl_config.dart";

import "../model/academic_calendar.dart";

part "academic_calendar_repo.g.dart";

@riverpod
Future<AcademicCalendar> academicCalendarRepo(Ref ref) async {
  final apiUrl = Env.mainRestApiUrl;
  const academicCalendarEndpoint = "/academic_calendars/";

  final response = await Future.wait([
    ref.getAndCacheData(
      apiUrl + academicCalendarEndpoint,
      TtlStrategy.get(TtlKey.academicCalendarRepository).inDays,
      AcademicCalendar.fromJson,
      extraValidityCheck: (_) => true,
      localizedOfflineMessage: "academic_calendar_view.offline_message",
      onRetry: ref.invalidateSelf,
    ),
  ]);
  return response.first;
}
