import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../../api_base_rest/client/json.dart";
import "../../../../api_base_rest/translations/translate.dart";
import "../../../../config/env.dart";
import "../../../../config/ttl_config.dart";
import "../filters_sheet.dart";
import "../model/tags.dart";

part "tags_repository.g.dart";

@riverpod
Future<IList<Tag>> tagsRepository(Ref ref) async {
  const endpoint = "/student_organization_tags";
  final apiUrl = Env.mainRestApiUrl;

  final response = await ref
      .getAndCacheDataWithTranslation(
        apiUrl + endpoint,
        TtlStrategy.get(TtlKey.tagsRepository).inDays,
        TagsData.fromJson,
        localizedOfflineMessage: FiltersSheet.localizedOfflineMessage,
        extraValidityCheck: (_) => true,
        onRetry: ref.invalidateSelf,
      )
      .castAsObject;

  return response.data;
}
