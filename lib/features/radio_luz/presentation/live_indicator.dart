import "dart:async";
import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";

class LiveIndicator extends HookWidget {
  /// child widget
  final Widget child;

  /// radius of indicator
  final double radius;

  /// radius of spread
  final double? spreadRadius;

  /// color of indicator
  final Color color;

  /// duration to animate the spread, it controls how fast the ripple happens,
  final Duration spreadDuration;

  /// duration to wait between spread animations. it controls the frequency of the ripples.
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
      final timer = Timer.periodic(
        spreadDuration + waitDuration,
        (timer) {
          animationKey.value++;
        },
      );
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
                  alignment: Alignment.center,
                  child: CircleAvatar(
                    radius: radius + effectiveSpreadRadius * value,
                    backgroundColor: color.withOpacity(.8 - value * .8),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: CircleAvatar(
                    radius: radius,
                    backgroundColor: color,
                    child: this.child,
                  ),
                ),
              ],
            ),
          );
        });
  }
}