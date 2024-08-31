import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../api_base/query_adapter.dart";
import "../../../config/ttl_config.dart";
import "getAcademicCalendar.graphql.dart";

part "academic_calendar_repo.g.dart";

typedef AcademicCalendar = Query$GetAcademicCalendar;
typedef AcademicCalendarData = Query$GetAcademicCalendar$AcademicCalendarData;
typedef AcademicWeekException = Query$GetAcademicCalendar$WeekExceptions;

@riverpod
Future<AcademicCalendar?> academicCalendarRepo(AcademicCalendarRepoRef ref) {
  return ref.queryGraphql(
    Options$Query$GetAcademicCalendar(),
    TtlKey.academicCalendarRepository,
  );
}

extension FixNestedTypesX on AcademicCalendar {
  AcademicCalendarData? get data => this.AcademicCalendarData;
  List<AcademicWeekException> get weeks => WeekExceptions;
}
