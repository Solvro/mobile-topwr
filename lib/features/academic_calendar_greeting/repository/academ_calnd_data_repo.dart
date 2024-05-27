import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../api_base/ttl/ttl_config.dart';
import '../../../api_base/watch_query_adapter.dart';
import 'getAcademicCalendar.graphql.dart';

part 'academ_calnd_data_repo.g.dart';

typedef AcademicCalendar = Query$GetAcademicCalendar$AcademicCalendarData;

@riverpod
Stream<AcademicCalendar?> examSessionCountdownRepository(
    ExamSessionCountdownRepositoryRef ref) async* {
  final stream = ref.watchQueryWithCache(
    WatchOptions$Query$GetAcademicCalendar(eagerlyFetchResults: true),
    TtlKey.academicCalendarRepository,
  );
  yield* stream.map(
    (event) => event?.AcademicCalendarData,
  );
}
