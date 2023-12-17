import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:topwr/features/home_view/repositories/getExamDate.graphql.dart';
import 'package:topwr/api_base/gql_client_provider.dart';
import 'package:topwr/api_base/watch_query_adapter.dart';

part 'exam_date_repository.g.dart';

typedef AcademicYearEndDate = Query$GetExamDate$academicYearEndDate;

@riverpod
Stream<AcademicYearEndDate?> examSessionCountdownRepository(ExamSessionCountdownRepositoryRef ref) async*{
  final client = await ref.watch(gqlClientProvider);
  final stream = ref.watchQueryWithCache(client, 
  WatchOptions$Query$GetExamDate(
    eagerlyFetchResults: true
  ),
  );
  yield* stream.map(
    (event)=>event?.academicYearEndDate
  );
}