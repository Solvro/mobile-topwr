import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../../api_base/watch_query_adapter.dart";
import "../../../../config/ttl_config.dart";
import "getTags.graphql.dart";

part "tags_repository.g.dart";

typedef Tag = Query$GetTags$Tags;

@riverpod
Stream<List<Tag?>?> tagsRepository(TagsRepositoryRef ref) async* {
  final stream = ref.watchQueryWithCache(
    WatchOptions$Query$GetTags(eagerlyFetchResults: true),
    TtlKey.tagsRepository,
  );
  yield* stream.map((event) => event?.Tags);
}
