import "package:topwr/features/academic_calendar/widgets/countdown_widget/digits_widgets.dart";
import "package:widgetbook/widgetbook.dart";

part "int_box.stories.g.dart";

class IntBoxStoryKnobs {
  final String singleInt;
  IntBoxStoryKnobs({required this.singleInt});
}

const meta = MetaWithArgs<IntBox, IntBoxStoryKnobs>();

final defaults = _Defaults(builder: (context, args) => IntBox(singleInt: args.singleInt));

final $default = IntBoxStory(args: IntBoxStoryKnobsArgs(singleInt: StringArg("1")));
