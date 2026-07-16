import "package:freezed_annotation/freezed_annotation.dart";

part "milestone_contributors_data.freezed.dart";
part "milestone_contributors_data.g.dart";

@freezed
abstract class MilestoneContributorData with _$MilestoneContributorData {
  const factory MilestoneContributorData({required int id}) = _MilestoneContributorData;
  factory MilestoneContributorData.fromJson(Map<String, dynamic> json) => _$MilestoneContributorDataFromJson(json);
}
