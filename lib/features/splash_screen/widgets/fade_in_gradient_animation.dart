import "package:flutter/material.dart";

class FadeInGradientAnimation extends StatefulWidget {
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
  State<FadeInGradientAnimation> createState() =>
      _FadeInGradientAnimationState();
}

class _FadeInGradientAnimationState extends State<FadeInGradientAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<LinearGradient> _gradientAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );
    _gradientAnimation = LinearGradientTween(
      begin: widget.gradientStart,
      end: widget.gradientStop,
    ).animate(_controller);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            gradient: _gradientAnimation.value,
          ),
        );
      },
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
