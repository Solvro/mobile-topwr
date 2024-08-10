import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../api_base/watch_query_adapter.dart";
import "../../../config/ttl_config.dart";
import "getGuide.graphql.dart";

part "guide_repository.g.dart";

typedef GuidePost = Query$GetGuide$FAQ_Types;
typedef _GetGuidePosts = WatchOptions$Query$GetGuide;

@riverpod
Stream<List<GuidePost?>?> guideRepository(
  GuideRepositoryRef ref,
) async* {
  final stream = ref.watchQueryWithCache(
    _GetGuidePosts(eagerlyFetchResults: true),
    TtlKey.guideRepository,
  );
  yield* stream.map((event) => event?.FAQ_Types);
}
