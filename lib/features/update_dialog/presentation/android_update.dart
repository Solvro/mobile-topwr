import "dart:async";
import "dart:io";

import "package:flutter/material.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";

import "../../../hooks/use_effect_on_init.dart";
import "../data/in_app_update_available.dart";

class AndroidUpdateWidget extends HookConsumerWidget {
  const AndroidUpdateWidget({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    assert(Platform.isAndroid, "InAppUpdate is only available on Android.");
    useEffectOnInit(() {
      if (Platform.isAndroid) {
        unawaited(ref.update());
      }
      return null;
    });
    return child;
  }
}
