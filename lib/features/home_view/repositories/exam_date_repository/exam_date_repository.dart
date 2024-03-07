import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../api_base/watch_query_adapter.dart';
import 'getExamDate.graphql.dart';

part 'exam_date_repository.g.dart';

@riverpod
Stream<DateTime?> examSessionCountdownRepository(
    ExamSessionCountdownRepositoryRef ref) async* {
  final stream = ref.watchQueryWithCache(
    WatchOptions$Query$GetExamDate(eagerlyFetchResults: true),
    "ExamSessionCountdownRepositoryRef",
  );
  yield* stream.map(
    (event) => event?.academicYearEndDate?.endDate,
  );
}
