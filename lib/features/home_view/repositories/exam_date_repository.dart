import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../api_base/watch_query_adapter.dart';
import '../../../api_base/gql_client_provider.dart';
import '../repositories/getExamDate.graphql.dart';
part 'exam_date_repository.g.dart';


@riverpod
Stream<DateTime?> examSessionCountdownRepository(ExamSessionCountdownRepositoryRef ref) async*{
  final client = await ref.watch(gqlClientProvider);
  final stream = ref.watchQueryWithCache(client, 
  WatchOptions$Query$GetExamDate(
    eagerlyFetchResults: true
  ),
  );
  yield* stream.map(
    (event)=>event?.academicYearEndDate?.endDate
  );
}