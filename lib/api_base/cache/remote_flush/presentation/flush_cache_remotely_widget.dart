import "dart:async";

import "package:flutter/material.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";

import "../../../../hooks/use_effect_on_init.dart";
import "../business/flush_cache_use_cases.dart";

class FlushCacheRemotelyWidget extends HookConsumerWidget {
  const FlushCacheRemotelyWidget({
    super.key,
    required this.child,
  });
  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useEffectOnInit(
      () {
        unawaited(Future.microtask(ref.flushAllCacheIfNeeded));
        return null;
      },
    );
    return child;
  }
}
