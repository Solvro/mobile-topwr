import "dart:math";

import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../features/navigator/navigation_stack.dart";

extension MediaQueryPaddingExtensionX on BuildContext {
  EdgeInsets get maxOfHorizontalViewPaddings {
    final padding = MediaQuery.paddingOf(this);
    final maxPadding = max(padding.left, padding.right);
    return EdgeInsets.only(right: maxPadding, left: maxPadding);
  }
}

class HorizontalSymmetricSafeArea extends ConsumerWidget {
  const HorizontalSymmetricSafeArea({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentRoute = ref.watch(currentRouteProvider)?.settings.name;
    final isMapView = currentRoute == "BuildingsRoute" || currentRoute == "ParkingsRoute";
    return Padding(
      padding: context.maxOfHorizontalViewPaddings,
      child: SafeArea(left: false, right: false, top: !isMapView, child: child),
    );
  }
}

class HorizontalSymmetricSafeAreaScaffold extends Scaffold {
  HorizontalSymmetricSafeAreaScaffold({
    super.key,
    required Widget body,
    super.floatingActionButton,
    super.bottomNavigationBar,
    super.appBar,
    super.backgroundColor,
  }) : super(body: HorizontalSymmetricSafeArea(child: body));
}
