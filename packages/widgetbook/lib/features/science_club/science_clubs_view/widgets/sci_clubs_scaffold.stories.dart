import "package:flutter/material.dart";
import "package:topwr/features/science_club/science_clubs_view/widgets/sci_clubs_scaffold.dart";
import "package:widgetbook/widgetbook.dart";

part "sci_clubs_scaffold.stories.g.dart";

const meta = Meta(SciClubsScaffold.new);

final $default = SciClubsScaffoldStory(
  args: SciClubsScaffoldArgs(
    initialQuery: NullableStringArg("robot"),
    child: Arg.fixed(
      const Center(
        child: Padding(padding: EdgeInsets.all(24), child: Text("Science clubs list preview")),
      ),
    ),
  ),
);
