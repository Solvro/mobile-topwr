import "package:flutter/material.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";

import "../../../../hooks/use_effect_on_init.dart";
import "../../../../utils/unwaited_microtask.dart";
import "../bussiness/flush_cache_use_cases.dart";

class FlushTranslationsCacheRemotelyWidget extends HookConsumerWidget {
  const FlushTranslationsCacheRemotelyWidget({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useEffectOnInit(() {
      unwaitedMicrotask(ref.flushTranslationsCacheIfNeededFromRemote);
      return null;
    });
    return child;
  }
}
