import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../api_base/watch_query_adapter.dart";
import "../../../config/ttl_config.dart";
import "getGuidePosts.graphql.dart";

part "guide_view_repository.g.dart";

typedef GuidePosts = Query$GetGuidePosts$FAQ_Types;
typedef _GetGuidePosts = WatchOptions$Query$GetGuidePosts;

@riverpod
Stream<List<GuidePosts?>?> guidePostsRepository(
  GuidePostsRepositoryRef ref,
) async* {
  final stream = ref.watchQueryWithCache(
    _GetGuidePosts(eagerlyFetchResults: true),
    TtlKey.guideDetailsRepository,
  );
  yield* stream.map((event) => event?.FAQ_Types);
}
