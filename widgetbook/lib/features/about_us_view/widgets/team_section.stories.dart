import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/widgets.dart";
import "package:topwr/api_base_rest/shared_models/image_data.dart";
import "package:topwr/features/about_us_view/bussiness/models.dart";
import "package:topwr/features/about_us_view/widgets/team_section.dart";
import "package:widgetbook/widgetbook.dart";

part "team_section.stories.g.dart";

final _mockTeamMember1 = (
  teamMemberName: "John Doe",
  image: null,
  subtitleForMilestone: "Flutter Developer",
  socialLinks: <String>["https://github.com/johndoe"].lock,
);

final _mockTeamMember2 = (
  teamMemberName: "Jane Smith",
  image: null,
  subtitleForMilestone: "UI/UX Designer",
  socialLinks: <String>["https://github.com/janesmith"].lock,
);

final _mockMultiversionTeam = IList<MultiversionTeam>([
  (versionName: "v1.0", members: IList([_mockTeamMember1])),
  (versionName: "v2.0", members: IList([_mockTeamMember1, _mockTeamMember2])),
]);

const meta = Meta<TeamSection>();

final $default = TeamSectionStory(args: TeamSectionArgs(multiversionTeam: Arg.fixed(_mockMultiversionTeam)));
