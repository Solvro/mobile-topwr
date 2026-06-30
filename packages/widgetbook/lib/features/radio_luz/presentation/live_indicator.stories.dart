import "package:flutter/material.dart";
import "package:topwr/features/radio_luz/presentation/live_indicator.dart";
import "package:widgetbook/widgetbook.dart";

part "live_indicator.stories.g.dart";

class LiveIndicatorStoryKnobs {
  final double radius;
  final double spreadRadius;
  final Color color;
  final Duration spreadDuration;
  final Duration waitDuration;
  LiveIndicatorStoryKnobs({
    required this.radius,
    required this.spreadRadius,
    required this.color,
    required this.spreadDuration,
    required this.waitDuration,
  });
}

const meta = Meta(LiveIndicator.new, argsType: LiveIndicatorStoryKnobs.new);

final defaults = _Defaults(
  builder: (context, args) => LiveIndicator(
    radius: args.radius,
    spreadRadius: args.spreadRadius,
    color: args.color,
    spreadDuration: args.spreadDuration,
    waitDuration: args.waitDuration,
  ),
);

final $default = LiveIndicatorStory(
  args: LiveIndicatorStoryKnobsArgs(
    radius: DoubleArg(5),
    spreadRadius: DoubleArg(16),
    color: ColorArg(const Color(0xFFE53935)),
    spreadDuration: Arg.fixed(const Duration(milliseconds: 800)),
    waitDuration: Arg.fixed(const Duration(milliseconds: 300)),
  ),
);
