import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../api_base/ttl/ttl_config.dart';
import '../../../../api_base/watch_query_adapter.dart';
import 'getStudyCirclesPreview.graphql.dart';

part 'study_circles_repository.g.dart';

typedef SciCirclePreview = Query$GetStudyCirclesPreview$scientificCircles;

@riverpod
Stream<List<SciCirclePreview?>?> studyCirclesRepository(
    StudyCirclesRepositoryRef ref) async* {
  final stream = ref.watchQueryWithCache(
    WatchOptions$Query$GetStudyCirclesPreview(eagerlyFetchResults: true),
    TtlKey.sciCirclesPreviewRepository,
  );
  yield* stream.map((event) => event?.scientificCircles);
}
