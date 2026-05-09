import "package:topwr/features/home_view/widgets/loading_widgets/big_scrollable_section_loading.dart";
import "package:widgetbook/widgetbook.dart";

part "big_scrollable_section_loading.stories.g.dart";

class BigScrollableSectionLoadingStoryKnobs {
  final double crossAxisForcedSize;
  BigScrollableSectionLoadingStoryKnobs({required this.crossAxisForcedSize});
}

const meta = MetaWithArgs<BigScrollableSectionLoading, BigScrollableSectionLoadingStoryKnobs>();

final defaults = _Defaults(
  builder: (context, args) => BigScrollableSectionLoading(crossAxisForcedSize: args.crossAxisForcedSize),
);

final $default = BigScrollableSectionLoadingStory(
  args: BigScrollableSectionLoadingStoryKnobsArgs(crossAxisForcedSize: DoubleArg(220)),
);
