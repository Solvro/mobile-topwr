import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:freezed_annotation/freezed_annotation.dart";

part "about_us.freezed.dart";
part "about_us.g.dart";

@freezed
abstract class AboutUs with _$AboutUs {
  const factory AboutUs({
    required String description,
    required String photoUrl,
    required IList<String> socialLinks,
    required IList<MultiversionTeam> multiversionTeam,
  }) = _AboutUs;
  factory AboutUs.fromJson(Map<String, dynamic> json) => _$AboutUsFromJson(json);
}

@freezed
abstract class TeamMember with _$TeamMember {
  const factory TeamMember({
    required String teamMemberName,
    required String imageUrl,
    required String subtitleForMilestone,
    required IList<String> socialLinks,
  }) = _TeamMember;

  factory TeamMember.fromJson(Map<String, dynamic> json) => _$TeamMemberFromJson(json);
}

@freezed
abstract class MultiversionTeam with _$MultiversionTeam {
  const factory MultiversionTeam({required String versionName, required IList<TeamMember> members}) = _MultiversionTeam;

  factory MultiversionTeam.fromJson(Map<String, dynamic> json) => _$MultiversionTeamFromJson(json);
}
