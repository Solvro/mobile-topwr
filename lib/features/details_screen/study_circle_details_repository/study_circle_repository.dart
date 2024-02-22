import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../api_base/gql_client_provider.dart';
import '../../../api_base/watch_query_adapter.dart';
import 'getScientificCircleDetails.graphql.dart';

part 'study_circle_repository.g.dart';

typedef StudyCircleDetails = Query$GetScientificCircleDetails$scientificCircle;

@riverpod
Stream<StudyCircleDetails?> studyCircleRepository(
    StudyCircleRepositoryRef ref, String id) async* {
  final client = await ref.watch(gqlClientProvider);
  final stream = ref.watchQueryWithCache(
      client,
      WatchOptions$Query$GetScientificCircleDetails(
          eagerlyFetchResults: true,
          variables: Variables$Query$GetScientificCircleDetails(id: id)));
  yield* stream.map((event) => event?.scientificCircle);
}
