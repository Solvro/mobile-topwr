import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../api/digital_guide_get_and_cache.dart";

part "image_repository.g.dart";

@riverpod
Future<String?> imageRepository(Ref ref, int imageID) async {
  return ref.getAndCacheDataFromDigitalGuide(
    "images/$imageID",
    (Map<String, dynamic> json) => json["image_1920w"] as String,
    onRetry: () => ref.invalidateSelf(),
  );
}
