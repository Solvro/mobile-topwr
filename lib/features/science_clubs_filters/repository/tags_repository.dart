import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../api_base/query_adapter.dart";
import "../../../config/ttl_config.dart";
import "../../../utils/ilist_nonempty.dart";
import "getTags.graphql.dart";

part "tags_repository.g.dart";

typedef Tag = Query$GetTags$Tags;

@riverpod
Future<IList<Tag>> tagsRepository(Ref ref) async {
  final results = await ref.queryGraphql(
    WatchOptions$Query$GetTags(eagerlyFetchResults: true),
    TtlKey.tagsRepository,
  );
  return (results?.Tags).toIList();
}
