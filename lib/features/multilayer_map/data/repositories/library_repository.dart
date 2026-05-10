import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../../api_base_rest/client/json.dart";
import "../../../../api_base_rest/translations/translate.dart";
import "../../../../config/env.dart";
import "../model/library.dart";

part "library_repository.g.dart";

@riverpod
Future<IList<Library>> librariesRepository(Ref ref) async {
  final apiUrl = Env.mainRestApiUrl;
  final librariesResponse = await ref
      .getAndCacheDataWithTranslation(
        "$apiUrl/libraries?photo=true&building=true",
        LibraryDataResponse.fromJson,
        extraValidityCheck: (_) => true,
        onRetry: ref.invalidateSelf,
      )
      .castAsObject;
  return librariesResponse.data.toIList();
}
