import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../api_base/gql_client_provider.dart';
import '../../../../api_base/watch_query_adapter.dart';
import 'getTags.graphql.dart';

part 'tags_repository.g.dart';

typedef Tag = Query$GetTags$tags; // just alias for shorter type name

@riverpod
Stream<List<Tag?>?> tagsRepository(TagsRepositoryRef ref) async* {
  final client = await ref.watch(gqlClientProvider);
  final stream = ref.watchQueryWithCache(
    client,
    WatchOptions$Query$GetTags(
      eagerlyFetchResults: true,
    ),
  );
  yield* stream.map(
        (event) => event?.tags,
  );
}