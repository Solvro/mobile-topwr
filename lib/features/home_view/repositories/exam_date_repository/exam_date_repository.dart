import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../api_base/ttl/ttl_config.dart';
import '../../../../api_base/watch_query_adapter.dart';
import 'getExamDate.graphql.dart';

part 'exam_date_repository.g.dart';

typedef AcademicCalendar = Query$GetExamDate$AcademicCalendarData;

@riverpod
Stream<AcademicCalendar?> examSessionCountdownRepository(
    ExamSessionCountdownRepositoryRef ref) async* {
  final stream = ref.watchQueryWithCache(
    WatchOptions$Query$GetExamDate(eagerlyFetchResults: true),
    TtlKey.examSessionCountdownRepository,
  );
  yield* stream.map(
    (event) => event?.AcademicCalendarData,
  );
}
