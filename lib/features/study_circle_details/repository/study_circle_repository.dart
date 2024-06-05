import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../config/ttl_config.dart';
import '../../../api_base/watch_query_adapter.dart';
import 'getScientificCircleDetails.graphql.dart';

part 'study_circle_repository.g.dart';

typedef StudyCircleDetails
    = Query$GetScientificCircleDetails$Scientific_Circles_by_id;

typedef _Vars = Variables$Query$GetScientificCircleDetails;
typedef _GetStudyCircles = WatchOptions$Query$GetScientificCircleDetails;

@riverpod
Stream<StudyCircleDetails?> studyCircleRepository(
    StudyCircleRepositoryRef ref, String id) async* {
  final stream = ref.watchQueryWithCache(
    _GetStudyCircles(
      eagerlyFetchResults: true,
      variables: _Vars(id: id),
    ),
    TtlKey.sciCirclesPreviewRepository,
  );
  yield* stream.map((event) => event?.Scientific_Circles_by_id);
}
