import "package:flutter/material.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";

import "../../../../hooks/use_effect_on_init.dart";
import "../../../../utils/unwaited_microtask.dart";
import "../bussiness/flush_cache_use_cases.dart";

class FlushCMSCacheRemotelyWidget extends HookConsumerWidget {
  const FlushCMSCacheRemotelyWidget({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useEffectOnInit(() {
      unwaitedMicrotask(ref.flushAllCacheIfNeededFromCms);
      return null;
    });
    return child;
  }
}
