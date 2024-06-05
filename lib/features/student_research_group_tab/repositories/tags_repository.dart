import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../api_base/watch_query_adapter.dart';
import '../../../config/ttl_config.dart';
import '../../../utils/watch_locale.dart';
import '../../../utils/where_non_null_iterable.dart';
import 'getTags.graphql.dart';

part 'tags_repository.g.dart';

typedef Tag = Query$GetTags$Tags; // just alias for shorter type name

@riverpod
Stream<List<Tag?>?> remoteTagsRepository(RemoteTagsRepositoryRef ref) async* {
  final stream = ref.watchQueryWithCache(
    WatchOptions$Query$GetTags(
      eagerlyFetchResults: true,
    ),
    TtlKey.tagsRepository,
  );
  yield* stream.map((event) => event?.Tags);
}

@riverpod
Tag allTagSingleton(AllTagSingletonRef ref) =>
    Tag(name: ref.watch(watchLocaleProvider).all);

@riverpod
Future<List<Tag>> tagsListRepository(TagsListRepositoryRef ref) async {
  final allTag = ref.watch(allTagSingletonProvider);
  final restTags = await ref.watch(remoteTagsRepositoryProvider.future);
  return [allTag, ...restTags.whereNonNull.toList()];
}
