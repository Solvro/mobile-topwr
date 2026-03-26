import "package:fast_immutable_collections/fast_immutable_collections.dart";

import "../../../api_base_rest/shared_models/image_data.dart";

typedef TeamMember = ({
  String teamMemberName,
  ImageData? image,
  String subtitleForMilestone,
  IList<String> socialLinks,
});
typedef MultiversionTeam = ({String versionName, IList<TeamMember> members});
typedef AboutUs = ({
  String description,
  ImageData? photo,
  IList<String> socialLinks,
  IList<MultiversionTeam> multiversionTeam,
});
