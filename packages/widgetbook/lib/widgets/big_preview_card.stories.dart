import "package:flutter/material.dart";
import "package:topwr/api_base_rest/shared_models/image_data.dart";
import "package:topwr/widgets/big_preview_card.dart";
import "package:widgetbook/widgetbook.dart";

part "big_preview_card.stories.g.dart";

class BigPreviewCardStoryKnobs {
  final String title;
  final String shortDescription;
  final ImageData? imageData;
  final DateTime? date;
  final BoxFit boxFit;
  final bool showVerifiedBadge;
  final bool showStrategicBadge;
  final EdgeInsets? imagePadding;
  BigPreviewCardStoryKnobs({
    required this.title,
    required this.shortDescription,
    this.imageData,
    this.date,
    required this.boxFit,
    required this.showVerifiedBadge,
    required this.showStrategicBadge,
    this.imagePadding,
  });
}

const meta = MetaWithArgs<BigPreviewCard, BigPreviewCardStoryKnobs>();

final defaults = _Defaults(
  builder: (context, args) => BigPreviewCard(
    title: args.title,
    shortDescription: args.shortDescription,
    imageData: args.imageData,
    date: args.date,
    onClick: () {},
    boxFit: args.boxFit,
    showVerifiedBadge: args.showVerifiedBadge,
    showStrategicBadge: args.showStrategicBadge,
    imagePadding: args.imagePadding,
  ),
);

final $default = BigPreviewCardStory();
