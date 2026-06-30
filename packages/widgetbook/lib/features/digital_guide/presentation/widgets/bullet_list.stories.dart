import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/widgets.dart";
import "package:topwr/features/digital_guide/presentation/widgets/bullet_list.dart";
import "package:widgetbook/widgetbook.dart";

part "bullet_list.stories.g.dart";

final _mockItems = IList<String>(const [
  "First item in the list",
  "Second item in the list",
  "Third item with more details",
]);

const meta = Meta(BulletList.new);

final $default = BulletListStory(args: BulletListArgs(items: Arg.fixed(_mockItems)));
