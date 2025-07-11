import "package:collection/collection.dart";
import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../../api_base_rest/cache/cache.dart";
import "../../../../api_base_rest/client/json.dart";
import "../../../../api_base_rest/translations/translate.dart";
import "../../../../config/env.dart";
import "../../about_us_view.dart";
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
  const versionsEndpoint = "/versions";

  final responses = await Future.wait([
    ref
        .getAndCacheDataWithTranslation(
          apiUrl + aboutUsEndpoint,
          AboutUsDataResponse.fromJson,
          extraValidityCheck: (_) => true,
          localizedOfflineMessage: AboutUsView.localizedOfflineMessage,
          onRetry: ref.invalidateSelf,
        )
        .castAsObject,
    ref
        .getAndCacheDataWithTranslation(
          apiUrl + teamMembersEndpoint,
          TeamMembersDataResponse.fromJson,
          extraValidityCheck: (_) => true,
          localizedOfflineMessage: AboutUsView.localizedOfflineMessage,
          onRetry: ref.invalidateSelf,
        )
        .castAsObject,
    ref
        .getAndCacheData(
          apiUrl + versionsEndpoint,
          VersionsDataResponse.fromJson,
          extraValidityCheck: (_) => true,
          localizedOfflineMessage: AboutUsView.localizedOfflineMessage,
          onRetry: ref.invalidateSelf,
        )
        .castAsObject,
  ]);

  final aboutUsResponse = responses[0] as AboutUsDataResponse;
  final teamMembersResponse = responses[1] as TeamMembersDataResponse;
  final versionsResponse = responses[2] as VersionsDataResponse;

  return (
    description: aboutUsResponse.data.aboutUsDetails.description,
    photoUrl: aboutUsResponse.data.aboutUsDetails.coverPhoto.url,
    socialLinks: aboutUsResponse.data.socialLinks.map((socialLink) => socialLink.url).toIList(),
    multiversionTeam: versionsResponse.data
        .map(
          (version) => (
            versionName: version.name,
            members: teamMembersResponse.data
                .where((member) => member.milestones.any((milestone) => milestone.id == version.milestoneId))
                .map((member) {
                  return (
                    teamMemberName: member.name,
                    imageUrl: member.image.url,
                    subtitleForMilestone: member.roles
                        .where((role) => role.meta.milestoneId == version.milestoneId)
                        .first
                        .name,
                    socialLinks: member.socialLinks.map((e) => e.url).toIList(),
                  );
                })
                .toIList(),
          ),
        )
        .sortedBy((team) => team.versionName)
        .toIList(),
  );
}
