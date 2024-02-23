import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'splash_screen_controller.dart';
import 'widgets/flutter_splash_screen.dart';

class SplashScreen extends ConsumerWidget {
  const SplashScreen({
    super.key,
    required this.child,
  });
  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(splashScreenControllerProvider.call(context));
    return switch (controller) {
      AsyncLoading() => const FlutterSplashScreen(),
      _ => child,
    };
  }
}
