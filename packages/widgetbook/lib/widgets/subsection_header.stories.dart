import "package:topwr/widgets/subsection_header.dart";
import "package:widgetbook/widgetbook.dart";

part "subsection_header.stories.g.dart";

class SubsectionHeaderStoryKnobs {
  final String title;
  final String? actionTitle;
  final double leftPadding;
  final double rightPadding;
  final bool addArrow;
  SubsectionHeaderStoryKnobs({
    required this.title,
    this.actionTitle,
    required this.leftPadding,
    required this.rightPadding,
    required this.addArrow,
  });
}

const meta = MetaWithArgs<SubsectionHeader, SubsectionHeaderStoryKnobs>();

final defaults = _Defaults(
  builder: (context, args) => SubsectionHeader(
    title: args.title,
    actionTitle: args.actionTitle,
    onClick: () {},
    leftPadding: args.leftPadding,
    rightPadding: args.rightPadding,
    addArrow: args.addArrow,
  ),
);

final $default = SubsectionHeaderStory();
