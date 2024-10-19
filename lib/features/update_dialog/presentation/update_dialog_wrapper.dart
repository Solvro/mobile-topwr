import "dart:io";

import "package:flutter/material.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";

import "android_update.dart";
import "ios_update.dart";

class UpdateDialogWrapper extends HookConsumerWidget {
  const UpdateDialogWrapper({
    super.key,
    required this.child,
  });
  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Platform.isAndroid
        ? AndroidUpdateWidget(child: child)
        : IosUpdateWidget(child: child);
  }
}
