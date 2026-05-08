import "package:topwr/features/sks/sks_chart/presentation/chart_elements/sks_chart_legend.dart";
import "package:widgetbook/widgetbook.dart";

part "sks_chart_legend_item.stories.g.dart";

class SksChartLegendItemStoryKnobs {
  final String text;
  final bool isPredicted;
  SksChartLegendItemStoryKnobs({required this.text, required this.isPredicted});
}

const meta = MetaWithArgs<SksChartLegendItem, SksChartLegendItemStoryKnobs>();

final defaults = _Defaults(
  builder: (context, args) => SksChartLegendItem(text: args.text, isPredicted: args.isPredicted),
);

final $default = SksChartLegendItemStory(
  args: SksChartLegendItemStoryKnobsArgs(text: StringArg("Measured number of users"), isPredicted: BoolArg(false)),
);
