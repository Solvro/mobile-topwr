import "dart:async";

import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../business/flush_cache_use_cases.dart";

// TODO(simon-the-shark): refactor this to use useEffectHook instead (if we decide on hooks)

class FlushCacheRemotelyWidget extends ConsumerStatefulWidget {
  const FlushCacheRemotelyWidget({super.key, required this.child});
  final Widget child;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _FlushCacheRemotelyWidgetState();
}

class _FlushCacheRemotelyWidgetState
    extends ConsumerState<FlushCacheRemotelyWidget> {
  @override
  void initState() {
    super.initState();
    unawaited(Future.microtask(ref.flushAllCacheIfNeeded));
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
