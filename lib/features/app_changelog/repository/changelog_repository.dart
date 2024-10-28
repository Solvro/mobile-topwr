import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../api_base/query_adapter.dart";
import "../../../config/ttl_config.dart";
import "get_changelog.graphql.dart";

part "changelog_repository.g.dart";

typedef Changelog = Query$GetChangelog$Changelog;

@riverpod
Future<IList<Changelog>> changelogRepository(
  Ref ref,
) async {
  final results = await ref.queryGraphql(
    Options$Query$GetChangelog(),
    TtlKey.changelogRepository,
  );

  return results?.Changelog.toIList() ?? const IList<Changelog>.empty();
}
