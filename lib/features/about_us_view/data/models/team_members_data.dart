import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:freezed_annotation/freezed_annotation.dart";

import "../../../../api_base_rest/shared_models/image_data.dart";
import "../../../../api_base_rest/shared_models/social_links_data.dart";

part "team_members_data.freezed.dart";
part "team_members_data.g.dart";

@freezed
abstract class TeamMembersDataResponse with _$TeamMembersDataResponse {
  const factory TeamMembersDataResponse({required IList<TeamMemberData> data}) = _TeamMembersDataResponse;
  factory TeamMembersDataResponse.fromJson(Map<String, dynamic> json) => _$TeamMembersDataResponseFromJson(json);
}

@freezed
abstract class TeamMemberData with _$TeamMemberData {
  const factory TeamMemberData({
    required String name,
    @JsonKey(name: "photo") required ImageData image,
    required IList<SocialLinksData> socialLinks,
    required IList<MilestoneData> milestones,
    required IList<RoleData> roles,
  }) = _TeamMemberData;
  factory TeamMemberData.fromJson(Map<String, dynamic> json) => _$TeamMemberDataFromJson(json);
}

@freezed
abstract class MilestoneData with _$MilestoneData {
  const factory MilestoneData({required String name, required int id}) = _MilestoneData;
  factory MilestoneData.fromJson(Map<String, dynamic> json) => _$MilestoneDataFromJson(json);
}

@freezed
abstract class RoleData with _$RoleData {
  const factory RoleData({required String name, required RoleMetaData meta}) = _RoleData;
  factory RoleData.fromJson(Map<String, dynamic> json) => _$RoleDataFromJson(json);
}

@freezed
abstract class RoleMetaData with _$RoleMetaData {
  const factory RoleMetaData({@JsonKey(name: "pivot_milestone_id") required int milestoneId}) = _RoleMetaData;
  factory RoleMetaData.fromJson(Map<String, dynamic> json) => _$RoleMetaDataFromJson(json);
}
