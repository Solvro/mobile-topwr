import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../../api_base_rest/client/json.dart";
import "../../../../api_base_rest/translations/translate.dart";
import "../../../../config/env.dart";
import "../../app_changelog.dart";
import "../models/changelog.dart";

part "my_changelog_repository.g.dart";

@riverpod
Future<Changelog?> changelogRepository(Ref ref) async {
  final url = "${Env.mainRestApiUrl}/versions?changes=true&sort=-updatedAt&limit=1";

  final changelogResponse = await ref
      .getAndCacheDataWithTranslation(
        url,
        ChangelogDataResponse.fromJson,
        extraValidityCheck: (_) => true,
        localizedOfflineMessage: AppChangelog.localizedOfflineMessage,
        onRetry: ref.invalidateSelf,
      )
      .castAsObject;

  return changelogResponse.data.firstOrNull;
}
