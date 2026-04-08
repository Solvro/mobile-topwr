import "package:flutter/material.dart";
import "package:topwr/features/sks/sks_menu/presentation/widgets/icon_banner.dart";
import "package:widgetbook/widgetbook.dart";

part "icon_banner.stories.g.dart";

class IconBannerStoryKnobs {
  final IconData icon;
  final Color color;
  final Color iconColor;
  final double size;
  final bool visible;
  IconBannerStoryKnobs({
    required this.icon,
    required this.color,
    required this.iconColor,
    required this.size,
    required this.visible,
  });
}

const meta = MetaWithArgs<IconBanner, IconBannerStoryKnobs>();

final defaults = _Defaults(
  builder: (context, args) => IconBanner(
    icon: args.icon,
    color: args.color,
    iconColor: args.iconColor,
    size: args.size,
    visible: args.visible,
    child: const SizedBox(width: 100, height: 100),
  ),
);

final $default = IconBannerStory(args: IconBannerStoryKnobsArgs(icon: Arg.fixed(Icons.restaurant)));
