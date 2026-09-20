import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../../api_base_rest/cache/cache.dart";
import "../../../../api_base_rest/client/json.dart";
import "../../../../api_base_rest/shared_models/image_data.dart";
import "../../../../config/env.dart";

part "activity_days_media_repository.g.dart";

@riverpod
Future<ImageData?> activityDaysFileImage(Ref ref, String contentKey) async {
  if (contentKey.isEmpty) return null;

  final response = await ref.getAndCacheData(
    "${Env.mainRestApiUrl}/files/$contentKey",
    ImageData.fromJson,
    extraValidityCheck: (_) => true,
    onRetry: ref.invalidateSelf,
  );
  return response.castAsObject;
}
