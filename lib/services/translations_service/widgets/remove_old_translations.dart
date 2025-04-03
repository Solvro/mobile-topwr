import "dart:async";

import "package:flutter/widgets.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";

import "../../../api_base/cache/remote_flush/business/flush_cache_use_cases.dart";
import "../../../hooks/use_effect_on_init.dart";

class RemoveOldTranslations extends HookConsumerWidget {
  const RemoveOldTranslations({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useEffectOnInit(() {
      unawaited(
        Future.microtask(ref.flushAllCacheIfNeeded),
      ); // TODO(simon-the-shark): @tomasz-trela flush translations cache instead of graphql cache
      return null;
    });
    return child;
  }
}
