import "../../../utils/determine_contact_icon.dart";
import "../../../utils/where_non_null_iterable.dart";
import "../repository/about_us_repository.dart";
import "member_data.dart";

class AboutUsDetails {
  final AboutUs? aboutUs;
  final List<AboutUsTeam>? aboutUsTeam;

  AboutUsDetails({this.aboutUs, this.aboutUsTeam});

  List<MemberData> getMemberData() {
    return aboutUsTeam.whereNonNull.map((e) {
      return MemberData(
        name: e.name,
        directusImageUrl: e.photo?.filename_disk,
        socialLinks: e.socialLinks.whereNonNull.map((e) => e.url).toList(),
        subtitle: e.subtitle,
      );
    }).toList();
  }

  List<ContactIconsModel> getSocialIcons() {
    return aboutUs?.solvroSocialLinks.whereNonNull
            .map(
              (e) => ContactIconsModel(url: e.url),
            )
            .toList() ??
        [];
  }
}
