import "package:topwr/features/sks/sks_chart/presentation/chart_elements/sks_chart_header.dart";
import "package:topwr/features/sks/sks_people_live/data/models/sks_user_data.dart";
import "package:widgetbook/widgetbook.dart";

part "sks_chart_header.stories.g.dart";

class SksChartHeaderStoryKnobs {
  final String numberOfPeople;
  final Trend trend;
  SksChartHeaderStoryKnobs({required this.numberOfPeople, required this.trend});
}

const meta = Meta(SksChartHeader.new, argsType: SksChartHeaderStoryKnobs.new);

final defaults = _Defaults(
  builder: (context, args) => SksChartHeader(numberOfPeople: args.numberOfPeople, trend: args.trend),
);

final $default = SksChartHeaderStory(
  args: SksChartHeaderStoryKnobsArgs(
    numberOfPeople: StringArg("184"),
    trend: EnumArg(Trend.increasing, values: Trend.values),
  ),
);
