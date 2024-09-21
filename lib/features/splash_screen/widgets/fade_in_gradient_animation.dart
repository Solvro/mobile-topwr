import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";

import "../../../hooks/use_effect_on_init.dart";

class FadeInGradientAnimation extends HookWidget {
  /// Animates between two LinearGradients on first build
  const FadeInGradientAnimation({
    super.key,
    required this.gradientStart,
    required this.gradientStop,
    required this.duration,
  });

  final LinearGradient gradientStart;
  final LinearGradient gradientStop;
  final Duration duration;

  @override
  Widget build(BuildContext context) {
    final controller = useAnimationController(duration: duration);
    final gradientAnimation = useAnimation(
      LinearGradientTween(
        begin: gradientStart,
        end: gradientStop,
      ).animate(controller),
    );

    useEffectOnInit(
      () {
        controller.forward();
        return null;
      },
    );

    return Container(
      decoration: BoxDecoration(
        gradient: gradientAnimation,
      ),
    );
  }
}

class LinearGradientTween extends Tween<LinearGradient> {
  LinearGradientTween({
    required LinearGradient begin,
    required LinearGradient end,
  }) : super(begin: begin, end: end);

  @override
  LinearGradient lerp(double t) => LinearGradient.lerp(begin, end, t)!;
}
