import "dart:async";

import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";

class LiveIndicator extends HookWidget {
  final Widget child;
  final double radius;
  final double spreadRadius;
  final Color color;
  final Duration spreadDuration;
  final Duration waitDuration;

  const LiveIndicator({
    super.key,
    this.child = const SizedBox.shrink(),
    this.radius = 4,
    required this.spreadRadius,
    required this.color,
    required this.spreadDuration,
    this.waitDuration = const Duration(seconds: 2),
  });

  @override
  Widget build(BuildContext context) {
    final effectiveSpreadRadius = spreadRadius;
    final controller = useAnimationController(duration: spreadDuration + waitDuration);

    final animation = useMemoized(
      () => Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(
          parent: controller,
          curve: const Interval(0, 1, curve: Curves.easeOut),
        ),
      ),
      [controller],
    );

    useEffect(() {
      unawaited(controller.repeat());
      return controller.stop;
    }, [controller]);

    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return SizedBox.square(
          dimension: (radius + effectiveSpreadRadius) * 2,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: radius * 2 + effectiveSpreadRadius * 2 * animation.value,
                height: radius * 2 + effectiveSpreadRadius * 2 * animation.value,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: color.withValues(alpha: 0.8 - animation.value * 0.8),
                ),
              ),
              Container(
                width: radius * 2,
                height: radius * 2,
                decoration: BoxDecoration(shape: BoxShape.circle, color: color),
                child: child,
              ),
            ],
          ),
        );
      },
      child: child,
    );
  }
}
