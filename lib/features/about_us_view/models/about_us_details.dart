import "package:fast_immutable_collections/fast_immutable_collections.dart";

import "../../../utils/determine_contact_icon.dart";
import "../../../utils/where_non_null_iterable.dart";
import "../repository/about_us_repository.dart";
import "member_data.dart";

class AboutUsDetails {
  final AboutUs? aboutUs;
  final IList<AboutUsTeam> aboutUsTeam;

  AboutUsDetails({required this.aboutUs, required this.aboutUsTeam});

  IList<MemberData> getMemberData() {
    return aboutUsTeam.map((e) {
      return MemberData(
        name: e.name,
        directusImageUrl: e.photo?.filename_disk,
        socialLinks: e.socialLinks.whereNonNull.map((e) => e.url).toIList(),
        subtitle: e.subtitle,
      );
    }).toIList();
  }

  IList<ContactIconsModel> getSocialIcons() {
    return (aboutUs?.solvroSocialLinks)
        .whereNonNull
        .map(
          (e) => ContactIconsModel(url: e.url),
        )
        .toIList();
  }
}
