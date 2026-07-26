import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/widgets.dart";
import "package:topwr/features/science_club/science_club_detail_view/science_club_detail_view.dart";
import "package:topwr/features/science_club/science_clubs_view/model/science_clubs.dart";
import "package:widgetbook/widgetbook.dart";

part "science_club_detail_view.stories.g.dart";

const meta = Meta(ScienceClubDetailView.new);

final $default = ScienceClubDetailViewStory(
  name: "Production view with hardcoded data",
  args: ScienceClubDetailViewArgs.fixed(id: 1365),
);
