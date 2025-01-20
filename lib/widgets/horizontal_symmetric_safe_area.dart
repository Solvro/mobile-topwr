import "dart:math";

import "package:flutter/material.dart";

extension MediaQueryPaddingExtensionX on BuildContext {
  EdgeInsets get maxOfHorizontalViewPaddings {
    final padding = MediaQuery.paddingOf(this);
    final maxPadding = max(padding.left, padding.right);
    return EdgeInsets.only(
      right: maxPadding,
      left: maxPadding,
    );
  }
}

class HorizontalSymmetricSafeArea extends StatelessWidget {
  const HorizontalSymmetricSafeArea({
    super.key,
    required this.child,
  });
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: context.maxOfHorizontalViewPaddings,
      child: SafeArea(
        left: false,
        right: false,
        child: child,
      ),
    );
  }
}

class HorizontalSymmetricSafeAreaScaffold extends Scaffold {
  HorizontalSymmetricSafeAreaScaffold({
    super.key,
    required Widget body,
    super.bottomNavigationBar,
    super.appBar,
    super.backgroundColor,
  }) : super(
          body: HorizontalSymmetricSafeArea(child: body),
        );
}
