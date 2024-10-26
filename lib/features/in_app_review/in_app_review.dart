import "dart:async";

import "package:flutter/material.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";

import "../../hooks/use_effect_on_init.dart";
import "business/in_app_rating_service_provider.dart";

class InAppReviewWidget extends HookConsumerWidget {
  const InAppReviewWidget({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final inAppRatingService = ref.read(inAppRatingServiceProvider);
    useEffectOnInit(() {
      unawaited(inAppRatingService.requestReviewIfNeeded());
      return null;
    });
    return child;
  }
}
