import "package:flutter/widgets.dart";
import "package:topwr/features/science_club/science_clubs_filters/widgets/filters_search.dart";
import "package:widgetbook/widgetbook.dart";

part "filters_search.stories.g.dart";

const meta = Meta(FiltersSearch.new);

final $default = FiltersSearchStory(
  setup: (context, widget, args) => SizedBox(height: 80, child: Stack(children: [widget])),
);
