import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../../api_base/watch_query_adapter.dart";
import "../../../../config/ttl_config.dart";
import "getNews.graphql.dart";

part "news_repository.g.dart";

typedef NewsPost = Query$GetNews$Posts;

@riverpod
Stream<List<NewsPost?>?> newsRepository(NewsRepositoryRef ref) async* {
  final stream = ref.watchQueryWithCache(
    WatchOptions$Query$GetNews(eagerlyFetchResults: true),
    TtlKey.newsRepository,
  );
  yield* stream.map((event) => event?.Posts);
}
