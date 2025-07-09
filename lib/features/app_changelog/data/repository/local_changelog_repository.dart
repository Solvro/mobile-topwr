import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../../config/shared_prefs.dart";

part "local_changelog_repository.g.dart";

//check if the user has seen the message
@riverpod
class LocalChangelogRepository extends _$LocalChangelogRepository {
  static const _repoPrefix = "changelog";
  String get _key => _repoPrefix + appVersion;

  @override
  Future<bool?> build(String appVersion) async {
    final prefs = await ref.watch(sharedPreferencesSingletonProvider.future);

    final userHasSeen = prefs.getBool(_key);
    if (userHasSeen == null) {
      final prefs = await ref.read(sharedPreferencesSingletonProvider.future);
      await prefs.setBool(_key, true);
      return false;
    } else {
      return userHasSeen;
    }
  }
}
