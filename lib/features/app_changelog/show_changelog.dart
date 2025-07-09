import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "app_changelog.dart";
import "data/repository/local_changelog_repository.dart";
import "data/repository/my_changelog_repository.dart";

Future<void> showChangelog(BuildContext context, WidgetRef ref) async {
  final changelog = await ref.read(changelogRepositoryProvider.future);

  if (changelog == null) return;

  final changelogSeen = await ref.read(localChangelogRepositoryProvider(changelog.name).future) ?? true;

  if (!changelogSeen && context.mounted && changelog.changes.isNotEmpty) {
    await showDialog<void>(context: context, builder: (context) => AppChangelog(changelog: changelog));
  }
}
