import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../api_base/watch_query_adapter.dart";
import "../../../config/ttl_config.dart";
import "getAcademicCalendar.graphql.dart";

part "academic_calendar_repo.g.dart";

typedef AcademicCalendar = Query$GetAcademicCalendar;
typedef AcademicCalendarData = Query$GetAcademicCalendar$AcademicCalendarData;
typedef AcademicWeekException = Query$GetAcademicCalendar$WeekExceptions;

@riverpod
Stream<AcademicCalendar?> academicCalendarRepo(AcademicCalendarRepoRef ref) {
  final stream = ref.watchQueryWithCache(
    WatchOptions$Query$GetAcademicCalendar(eagerlyFetchResults: true),
    TtlKey.academicCalendarRepository,
  );
  return stream;
}

extension FixNestedTypesX on AcademicCalendar {
  AcademicCalendarData? get data => this.AcademicCalendarData;
  List<AcademicWeekException> get weeks => WeekExceptions;
}
