import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";

/// A widget that displays a heart icon banner in the top-right corner, similar to Banner but with an icon.
class IconBanner extends HookWidget {
  const IconBanner({
    super.key,
    required this.child,
    required this.icon,
    required this.color,
    required this.iconColor,
    this.size = 16.0,
    this.visible = true,
  });

  /// The widget below this widget in the tree.
  final Widget child;

  /// The icon to display in the banner.
  final IconData icon;

  /// The background color of the banner.
  final Color color;

  /// The color of the icon.
  final Color iconColor;

  /// The size of the icon.
  final double size;

  /// Whether the banner is visible.
  final bool visible;

  @override
  Widget build(BuildContext context) {
    final previousVisible = usePrevious(visible);
    final isFirstBuild = previousVisible == null;

    // Calculate banner size based on icon size and padding
    const padding = 12.0;
    final bannerSize = size + (padding * 2);
    final targetValue = visible ? 1.0 : 0.0;

    // On first build, always start from 0.0 to avoid flash
    // On subsequent builds, animate from previous state
    final beginValue = isFirstBuild ? 0.0 : (previousVisible ? 1.0 : 0.0);

    return Stack(
      clipBehavior: Clip.none,
      children: [
        child,
        Positioned(
          top: 0,
          right: 0,
          child: IgnorePointer(
            ignoring: !visible,
            child: TweenAnimationBuilder<double>(
              key: ValueKey(visible),
              tween: Tween(begin: beginValue, end: targetValue),
              duration: (isFirstBuild && !visible) || beginValue == targetValue
                  ? Duration.zero
                  : const Duration(milliseconds: 150),
              curve: visible ? Curves.easeInOut : Curves.easeOut,
              builder: (context, opacityValue, child) {
                return Opacity(
                  opacity: opacityValue,
                  child: visible
                      ? TweenAnimationBuilder<double>(
                          key: ValueKey(visible),
                          tween: Tween(begin: 0, end: 1),
                          duration: const Duration(milliseconds: 150),
                          curve: Curves.easeOutBack,
                          builder: (context, scaleValue, child) {
                            return Transform.scale(scale: scaleValue, child: child);
                          },
                          child: child,
                        )
                      : child,
                );
              },
              child: SizedBox(
                width: bannerSize,
                height: bannerSize,
                child: CustomPaint(
                  painter: _BannerPainter(color: color),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.all(padding / 3),
                      child: Icon(icon, color: iconColor, size: size),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _BannerPainter extends CustomPainter {
  const _BannerPainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;

    // Draw a diagonal banner in the top-right corner
    // Triangle with diagonal edge going from top-left to bottom-right
    final path = Path()
      ..moveTo(size.width, 0) // Start at top-right corner
      ..lineTo(size.width, size.height) // Down along right edge
      ..lineTo(0, 0) // Diagonal line from bottom-right to top-left (creates diagonal from top-left to bottom-right)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
