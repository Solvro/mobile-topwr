import "dart:async";

import "package:flutter/widgets.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";

import "../../../hooks/use_effect_on_init.dart";
import "../business/flush_cache_drift_use_cases.dart";

class RemoveOldTranslations extends HookConsumerWidget {
  const RemoveOldTranslations({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useEffectOnInit(() {
      unawaited(Future.microtask(ref.flushOldData));
      return null;
    });
    return child;
  }
}
