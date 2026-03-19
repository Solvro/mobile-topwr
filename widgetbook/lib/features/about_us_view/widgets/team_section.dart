import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/widgets.dart";
import "package:topwr/features/about_us_view/bussiness/models.dart";
import "package:topwr/features/about_us_view/widgets/team_section.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

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

@widgetbook.UseCase(name: "default", type: TeamSection)
Widget useCaseTeamSection(BuildContext context) {
  return TeamSection(multiversionTeam: _mockMultiversionTeam);
}
