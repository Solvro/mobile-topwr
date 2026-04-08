import "package:topwr/features/science_club/science_clubs_view/science_clubs_view.dart";
import "package:widgetbook/widgetbook.dart";

part "science_clubs_view.stories.g.dart";

class ScienceClubsViewStoryKnobs {
  final String? tagsIdsSequence;
  final String? deptsIdsSequence;
  final String? typesSequence;
  final String? initialQuery;
  ScienceClubsViewStoryKnobs({this.tagsIdsSequence, this.deptsIdsSequence, this.typesSequence, this.initialQuery});
}

const meta = MetaWithArgs<ScienceClubsView, ScienceClubsViewStoryKnobs>();

final defaults = _Defaults(
  builder: (context, args) => ScienceClubsView(
    tagsIdsSequence: args.tagsIdsSequence,
    deptsIdsSequence: args.deptsIdsSequence,
    typesSequence: args.typesSequence,
    initialQuery: args.initialQuery,
  ),
);

final $default = ScienceClubsViewStory();
