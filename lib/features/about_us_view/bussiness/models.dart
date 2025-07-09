import "package:fast_immutable_collections/fast_immutable_collections.dart";

typedef TeamMember = ({String teamMemberName, String imageUrl, String subtitleForMilestone, IList<String> socialLinks});
typedef MultiversionTeam = ({String versionName, IList<TeamMember> members});
typedef AboutUs = ({
  String description,
  String photoUrl,
  IList<String> socialLinks,
  IList<MultiversionTeam> multiversionTeam,
});
