import "package:flutter/material.dart";
import "package:topwr/widgets/horizontal_symmetric_safe_area.dart";
import "package:widgetbook/widgetbook.dart";

part "horizontal_symmetric_safe_area_scaffold.stories.g.dart";

class HorizontalSymmetricSafeAreaScaffoldStoryKnobs {
  final Color? backgroundColor;
  final bool top;
  HorizontalSymmetricSafeAreaScaffoldStoryKnobs({this.backgroundColor, required this.top});
}

const meta = MetaWithArgs<HorizontalSymmetricSafeAreaScaffold, HorizontalSymmetricSafeAreaScaffoldStoryKnobs>();

final defaults = _Defaults(
  builder: (context, args) => HorizontalSymmetricSafeAreaScaffold(
    body: const SizedBox(width: 100, height: 100),
    bottomNavigationBar: const SizedBox(width: 100, height: 100),
    backgroundColor: args.backgroundColor,
    top: args.top,
  ),
);

final $default = HorizontalSymmetricSafeAreaScaffoldStory();
