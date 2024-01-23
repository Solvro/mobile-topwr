
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../api_base/gql_client_provider.dart';
import '../../../../api_base/watch_query_adapter.dart';
import 'getStudyCirclesPreview.graphql.dart';
part 'study_circles_repository.g.dart';

typedef InfosPreview = Query$GetStudyCirclesPreview$scientificCircles;

@riverpod
Stream<List<InfosPreview?>?> studyCirclesRepository (StudyCirclesRepositoryRef ref) async*{
  final client = await ref.watch(gqlClientProvider);
  final stream = ref.watchQueryWithCache(
    client,
    WatchOptions$Query$GetStudyCirclesPreview(
        eagerlyFetchResults: true
    ),
  );
  yield* stream.map((event) => event?.scientificCircles);
}
