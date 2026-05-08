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
    body: const DecoratedBox(
      decoration: BoxDecoration(color: Color(0xFFE3F2FD)),
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Text("Scaffold body with symmetric horizontal safe area"),
        ),
      ),
    ),
    bottomNavigationBar: const DecoratedBox(
      decoration: BoxDecoration(color: Color(0xFFBBDEFB)),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Text("Bottom navigation content"),
      ),
    ),
    backgroundColor: args.backgroundColor,
    top: args.top,
  ),
);

final $default = HorizontalSymmetricSafeAreaScaffoldStory(
  args: HorizontalSymmetricSafeAreaScaffoldStoryKnobsArgs.fixed(backgroundColor: Colors.white, top: true),
);
