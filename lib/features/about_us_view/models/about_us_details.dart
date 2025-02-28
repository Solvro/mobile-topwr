import "package:fast_immutable_collections/fast_immutable_collections.dart";

import "../../../utils/determine_contact_icon.dart";
import "../../../utils/where_non_null_iterable.dart";
import "../repository/about_us_repository.dart";
import "member_data.dart";

typedef MultiversionTeam = ({String versionName, IList<MemberData> members});

class AboutUsDetails {
  final AboutUs? aboutUs;
  final IList<TeamVersion> versions;
  final IList<TeamMember> teamMembers;
  AboutUsDetails({required this.aboutUs, required this.versions, required this.teamMembers});

  IList<MultiversionTeam> getMemberData() {
    return versions.map((version) {
      final members =
          teamMembers.where((member) => member.appVersion?.id == version.id).map((e) {
            return MemberData(
              name: e.name,
              directusImageUrl: e.photo?.filename_disk,
              socialLinks:
                  e.socialLinks.whereNonNull.map((e) => e.AboutUs_Team_Social_Links_id?.url).whereNonNull.toIList(),
              subtitle: e.subtitle,
            );
          }).toIList();
      return (versionName: version.name ?? "v.0.0.0", members: members);
    }).toIList();
  }

  IList<ContactIconsModel> getSocialIcons() {
    return (aboutUs?.solvroSocialLinks).whereNonNull.map((e) => ContactIconsModel(url: e.url)).toIList();
  }
}
