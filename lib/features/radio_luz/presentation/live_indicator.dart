import "dart:async";
import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";

class LiveIndicator extends HookWidget {
  final Widget child;
  final double radius;
  final double? spreadRadius;
  final Color color;
  final Duration spreadDuration;
  final Duration waitDuration;

  const LiveIndicator({
    super.key,
    this.child = const SizedBox.shrink(),
    this.radius = 4,
    this.spreadRadius,
    this.color = Colors.red,
    this.spreadDuration = const Duration(seconds: 1),
    this.waitDuration = const Duration(seconds: 2),
  });

  @override
  Widget build(BuildContext context) {
    final effectiveSpreadRadius = spreadRadius ?? (radius * .45);
    final animationKey = useState(0);

    useEffect(() {
      final timer = Timer.periodic(spreadDuration + waitDuration, (timer) {
        animationKey.value++;
      });
      return timer.cancel;
    }, []);

    return TweenAnimationBuilder(
      key: ValueKey(animationKey.value),
      duration: spreadDuration,
      tween: Tween<double>(begin: 0, end: 1),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        return SizedBox(
          height: (effectiveSpreadRadius + radius) * 2,
          width: (effectiveSpreadRadius + radius) * 2,
          child: Stack(
            children: [
              Align(
                child: CircleAvatar(
                  radius: radius + effectiveSpreadRadius * value,
                  backgroundColor: color.withValues(alpha: .8 - value * .8),
                ),
              ),
              Align(
                child: CircleAvatar(radius: radius, backgroundColor: color, child: this.child),
              ),
            ],
          ),
        );
      },
    );
  }
}
