import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "in_app_rating_service.dart";

part "in_app_rating_service_provider.g.dart";

@riverpod
InAppRatingService inAppRatingService(Ref ref) {
  return InAppRatingService(ref);
}
