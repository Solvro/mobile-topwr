import "package:flutter/material.dart";
import "package:topwr/features/splash_screen/widgets/fade_in_gradient_animation.dart";
import "package:widgetbook/widgetbook.dart";

part "fade_in_gradient_animation.stories.g.dart";

class FadeInGradientAnimationStoryKnobs {
  final LinearGradient gradientStart;
  final LinearGradient gradientStop;
  final Duration duration;
  FadeInGradientAnimationStoryKnobs({required this.gradientStart, required this.gradientStop, required this.duration});
}

const meta = MetaWithArgs<FadeInGradientAnimation, FadeInGradientAnimationStoryKnobs>();

final defaults = _Defaults(
  builder: (context, args) => FadeInGradientAnimation(
    gradientStart: args.gradientStart,
    gradientStop: args.gradientStop,
    duration: args.duration,
  ),
);

const _gradientStart = LinearGradient(colors: [Color(0xFF2196F3), Color(0xFFE91E63)]);
const _gradientStop = LinearGradient(colors: [Color(0xFF4CAF50), Color(0xFFFFC107)]);

final $default = FadeInGradientAnimationStory(
  args: FadeInGradientAnimationStoryKnobsArgs(
    gradientStart: Arg.fixed(_gradientStart),
    gradientStop: Arg.fixed(_gradientStop),
  ),
);
