import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:package_info_plus/package_info_plus.dart";

import "app_changelog.dart";
import "data/models/changelog.dart";
import "data/repository/local_changelog_repository.dart";
import "data/repository/my_changelog_repository.dart";

bool isChangelogForAppVersion({required String appVersion, required Changelog changelog}) {
  final normalizedAppVersion = appVersion.trim();
  final normalizedChangelogVersion = changelog.name.trim();

  if (normalizedAppVersion.isEmpty) {
    return false;
  }

  return normalizedChangelogVersion == normalizedAppVersion;
}

Future<void> showChangelog(BuildContext context, WidgetRef ref) async {
  final changelog = await ref.read(changelogRepositoryProvider.future);

  if (changelog == null) return;

  final packageInfo = await PackageInfo.fromPlatform();
  if (!isChangelogForAppVersion(appVersion: packageInfo.version, changelog: changelog)) {
    return;
  }

  final changelogSeen = await ref.read(localChangelogRepositoryProvider(packageInfo.version).future) ?? true;

  if (!changelogSeen && context.mounted && changelog.changes.isNotEmpty) {
    await showDialog<void>(
      context: context,
      builder: (context) => AppChangelog(changelog: changelog),
    );
  }
}
