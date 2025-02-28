import "package:flutter/material.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:upgrader/upgrader.dart";

import "../../navigator/app_router.dart";

class IosUpdateWidget extends ConsumerWidget {
  const IosUpdateWidget({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return UpgradeAlert(
      navigatorKey: ref.watch(appRouterProvider).navigatorKey,
      dialogStyle: UpgradeDialogStyle.cupertino,
      shouldPopScope: () => true,
      child: child,
    );
  }
}
