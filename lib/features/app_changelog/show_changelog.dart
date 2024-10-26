import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "app_changelog.dart";
import "repository/changelog_repository.dart";
import "repository/local_changelog_repository.dart";

Future<void> showChangelog(BuildContext context, WidgetRef ref) async {
  
  final changelog = await ref.watch(changelogRepositoryProvider.future);

  if (changelog.isEmpty) {
    return;
  }

  final changelogInstance = changelog[0];
  final changelogStatus = await ref.read(localChangelogRepositoryProvider(changelogInstance.versionString!).future);

  if(changelogStatus == false && context.mounted) {
    await showDialog(
      context: context,
      builder: (context) => AppChangelog(changelog: changelogInstance),
    );
  }
}
