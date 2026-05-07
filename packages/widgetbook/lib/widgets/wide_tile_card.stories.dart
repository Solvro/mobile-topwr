import "package:flutter/widgets.dart";
import "package:topwr/widgets/wide_tile_card.dart";
import "package:widgetbook/widgetbook.dart";

part "wide_tile_card.stories.g.dart";

class WideTileCardStoryKnobs {
  final String title;
  final String subtitle;
  final LinearGradient? activeGradient;
  final bool isActive;
  final List<BoxShadow>? activeShadows;
  final CrossAxisAlignment crossAxisAlignment;
  final bool showBadge;
  final bool showStrategicBadge;
  final bool fixedTrailingHeight;
  WideTileCardStoryKnobs({
    required this.title,
    required this.subtitle,
    this.activeGradient,
    required this.isActive,
    this.activeShadows,
    required this.crossAxisAlignment,
    required this.showBadge,
    required this.showStrategicBadge,
    required this.fixedTrailingHeight,
  });
}

const meta = MetaWithArgs<WideTileCard, WideTileCardStoryKnobs>();

final defaults = _Defaults(
  builder: (context, args) => WideTileCard(
    title: args.title,
    subtitle: args.subtitle,
    trailing: const SizedBox(width: 100, height: 100),
    onTap: () {},
    activeGradient: args.activeGradient,
    isActive: args.isActive,
    activeShadows: args.activeShadows,
    crossAxisAlignment: args.crossAxisAlignment,
    showBadge: args.showBadge,
    showStrategicBadge: args.showStrategicBadge,
    fixedTrailingHeight: args.fixedTrailingHeight,
  ),
);

final $default = WideTileCardStory();
