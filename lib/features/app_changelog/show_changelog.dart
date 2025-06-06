import "package:collection/collection.dart";
import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:package_info_plus/package_info_plus.dart";

import "app_changelog.dart";
import "repository/changelog_repository.dart";
import "repository/local_changelog_repository.dart";

Future<void> showChangelog(BuildContext context, WidgetRef ref) async {
  final changelogs = await ref.read(changelogRepositoryProvider.future);
  if (changelogs.isEmpty) return;

  final appVersion = await _getAppVersion();
  final changelogForCurrentVersion = _findChangelogForVersion(changelogs, appVersion);

  if (changelogForCurrentVersion == null) return;

  final changelogSeen =
      await ref.read(localChangelogRepositoryProvider(changelogForCurrentVersion.versionString!).future) ?? true;

  if (!changelogSeen && context.mounted && _canShowDialog(changelogForCurrentVersion)) {
    await showDialog<void>(context: context, builder: (context) => AppChangelog(changelog: changelogForCurrentVersion));
  }
}

bool _canShowDialog(Changelog changelog) {
  final changes = changelog.changes;

  return changelog.versionString != null && changes != null && changes.every((change) => change != null);
}

Future<String> _getAppVersion() async {
  final packageInfo = await PackageInfo.fromPlatform();
  return packageInfo.version;
}

Changelog? _findChangelogForVersion(IList<Changelog> changelogs, String version) {
  return changelogs.firstWhereOrNull((changelog) => changelog.versionString == version);
}
