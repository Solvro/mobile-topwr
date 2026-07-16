import "package:collection/collection.dart";
import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../../api_base_rest/cache/cache.dart";
import "../../../../api_base_rest/client/json.dart";
import "../../../../api_base_rest/translations/translate.dart";
import "../../../../config/env.dart";
import "../../bussiness/models.dart";
import "../models/about_us_data.dart";
import "../models/team_members_data.dart";
import "../models/versions_data.dart";

part "about_us_repository.g.dart";

@riverpod
Future<AboutUs> aboutUsRepository(Ref ref) async {
  final apiUrl = Env.mainRestApiUrl;
  const aboutUsEndpoint = "/about_us";
  const teamMembersEndpoint = "/contributors?milestones=true&socialLinks=true&photo=true&roles=true";
  const milestonesEndpoint = "/milestones?contributors=true";

  final responses = await Future.wait([
    ref
        .getAndCacheDataWithTranslation(
          apiUrl + aboutUsEndpoint,
          AboutUsDataResponse.fromJson,
          extraValidityCheck: (_) => true,
          onRetry: ref.invalidateSelf,
        )
        .castAsObject,
    ref
        .getAndCacheDataWithTranslation(
          apiUrl + teamMembersEndpoint,
          TeamMembersDataResponse.fromJson,
          extraValidityCheck: (_) => true,
          onRetry: ref.invalidateSelf,
        )
        .castAsObject,
    ref
        .getAndCacheData(
          apiUrl + milestonesEndpoint,
          VersionsDataResponse.fromJson,
          extraValidityCheck: (_) => true,
          onRetry: ref.invalidateSelf,
        )
        .castAsObject,
  ]);

  final aboutUsResponse = responses[0] as AboutUsDataResponse;
  final teamMembersResponse = responses[1] as TeamMembersDataResponse;
  final milestonesResponse = responses[2] as VersionsDataResponse;

  return (
    description: aboutUsResponse.data.aboutUsDetails.description,
    photo: aboutUsResponse.data.aboutUsDetails.coverPhoto,
    socialLinks: aboutUsResponse.data.socialLinks,
    multiversionTeam: milestonesResponse.data
        .map(
          (milestone) => (
            versionName: milestone.name,
            members: _membersForMilestone(
              teamMembers: teamMembersResponse.data,
              milestoneId: milestone.id,
              contributorOrder: milestone.contributors.map((contributor) => contributor.id).toIList(),
            ),
          ),
        )
        .sortedBy((team) => team.versionName)
        .toIList(),
  );
}

IList<TeamMember> _membersForMilestone({
  required IList<TeamMemberData> teamMembers,
  required int milestoneId,
  required IList<int> contributorOrder,
}) {
  final orderIndex = {for (final (index, contributorId) in contributorOrder.indexed) contributorId: index};

  return teamMembers
      .where((member) => member.milestones.any((milestone) => milestone.id == milestoneId))
      .sortedBy((member) => orderIndex[member.id] ?? contributorOrder.length)
      .map((member) {
        return (
          teamMemberName: member.name,
          image: member.image,
          subtitleForMilestone:
              member.roles.where((role) => role.meta.milestoneId == milestoneId).firstOrNull?.name ?? "",
          socialLinks: member.socialLinks.map((e) => e.url).toIList(),
        );
      })
      .toIList();
}
