import "package:flutter/material.dart";
import "package:topwr/features/parkings/parkings_view/widgets/parking_favourite.dart";
import "package:widgetbook/widgetbook.dart";

part "favourite_icon.stories.g.dart";

class FavouriteIconStoryKnobs {
  final Color color;
  FavouriteIconStoryKnobs({required this.color});
}

const meta = MetaWithArgs<FavouriteIcon, FavouriteIconStoryKnobs>();

final defaults = _Defaults(
  builder: (context, args) => FavouriteIcon(icon: Icons.favorite, color: args.color),
);

final $default = FavouriteIconStory();
