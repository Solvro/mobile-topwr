import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../api_base/query_adapter.dart";
import "../../../config/ttl_config.dart";
import "../../../utils/ilist_nonempty.dart";
import "getGuide.graphql.dart";

part "guide_repository.g.dart";

typedef GuidePost = Query$GetGuide$FAQ_Types;

@riverpod
Future<IList<GuidePost>> guideRepository(Ref ref) async {
  final results = await ref.queryGraphql(Options$Query$GetGuide(), TtlKey.guideRepository);
  return (results?.FAQ_Types).toIList();
}
