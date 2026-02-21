import "dart:math";

import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../features/navigator/app_router.dart";
import "../features/navigator/navigation_stack.dart";
import "../features/navigator/utils/navigation_commands.dart";
import "../features/radio_luz/service/radio_player_controller.dart";
import "../theme/app_theme.dart";

extension MediaQueryPaddingExtensionX on BuildContext {
  EdgeInsets get maxOfHorizontalViewPaddings {
    final padding = MediaQuery.paddingOf(this);
    final maxPadding = max(padding.left, padding.right);
    return EdgeInsets.only(right: maxPadding, left: maxPadding);
  }
}

class HorizontalSymmetricSafeArea extends StatelessWidget {
  const HorizontalSymmetricSafeArea({super.key, required this.child, this.top = true});
  final Widget child;
  final bool top;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: context.maxOfHorizontalViewPaddings,
      child: SafeArea(left: false, right: false, top: top, child: child),
    );
  }
}

class HorizontalSymmetricSafeAreaScaffold extends ConsumerWidget {
  const HorizontalSymmetricSafeAreaScaffold({
    super.key,
    required this.body,
    this.bottomNavigationBar,
    this.appBar,
    this.backgroundColor,
    this.extraFabs,
    this.top = true,
  });

  final Widget body;
  final Widget? bottomNavigationBar;
  final PreferredSizeWidget? appBar;
  final Color? backgroundColor;
  final List<Widget>? extraFabs;
  final bool top;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final shouldDisplayRadio =
        ref.watch(radioControllerProvider).isPlaying &&
        ref.watch(currentRouteProvider)?.settings.name != RadioLuzRoute.name;

    final fabs = <Widget>[
      if (shouldDisplayRadio)
        FloatingActionButton(
          heroTag: "radioFab",
          elevation: 3,
          backgroundColor: context.colorScheme.primary,
          onPressed: () async {
            await ref.navigateToRadioLuz();
          },
          child: const Icon(Icons.radio),
        ),
      ...?extraFabs,
    ];

    return Scaffold(
      appBar: appBar,
      bottomNavigationBar: bottomNavigationBar,
      backgroundColor: backgroundColor,
      body: HorizontalSymmetricSafeArea(top: top, child: body),
      floatingActionButton: fabs.isNotEmpty ? _FloatingActionButtons(fabs: fabs) : null,
    );
  }
}

class _FloatingActionButtons extends StatelessWidget {
  const _FloatingActionButtons({required this.fabs});

  final List<Widget> fabs;

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min, spacing: 8, children: [for (final fab in fabs) fab]);
  }
}
