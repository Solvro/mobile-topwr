import "package:collection/collection.dart";
import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../../api_base_rest/cache/cache.dart";
import "../../../../config/env.dart";
import "../../../../config/ttl_config.dart";
import "../../about_us_view.dart";
import "../models/about_us.dart";
import "../models/about_us_data.dart";
import "../models/team_members_data.dart";
import "../models/versions_data.dart";

part "about_us_repository.g.dart";

@riverpod
Future<AboutUs> aboutUsRepository(Ref ref) async {
  final apiUrl = Env.mainRestApiUrl;
  const aboutUsEndpoint = "/about_us";
  const teamMembersEndpoint = "/contributors?milestones=true&socialLinks=true&photo=true";
  const versionsEndpoint = "/versions";

  final aboutUsResponse = await ref.getAndCacheData(
    apiUrl + aboutUsEndpoint,
    TtlStrategy.get(TtlKey.aboutUsRepository).inDays,
    AboutUsDataResponse.fromJson,
    extraValidityCheck: (_) => true,
    localizedOfflineMessage: AboutUsView.localizedOfflineMessage,
    onRetry: ref.invalidateSelf,
  );

  final teamMembersResponse = await ref.getAndCacheData(
    apiUrl + teamMembersEndpoint,
    TtlStrategy.get(TtlKey.aboutUsRepository).inDays,
    TeamMembersDataResponse.fromJson,
    extraValidityCheck: (_) => true,
    localizedOfflineMessage: AboutUsView.localizedOfflineMessage,
    onRetry: ref.invalidateSelf,
  );

  final versionsResponse = await ref.getAndCacheData(
    apiUrl + versionsEndpoint,
    TtlStrategy.get(TtlKey.aboutUsRepository).inDays,
    VersionsDataResponse.fromJson,
    extraValidityCheck: (_) => true,
    localizedOfflineMessage: AboutUsView.localizedOfflineMessage,
    onRetry: ref.invalidateSelf,
  );

  return AboutUs(
    description: aboutUsResponse.data.aboutUsDetails.description,
    photoUrl: aboutUsResponse.data.aboutUsDetails.coverPhoto.url,
    socialLinks: aboutUsResponse.data.socialLinks.map((socialLink) => socialLink.url).toIList(),
    multiversionTeam:
        versionsResponse.data
            .map(
              (version) => MultiversionTeam(
                versionName: version.name,
                members:
                    teamMembersResponse.data
                        .where((member) => member.milestones.any((milestone) => milestone.id == version.milestoneId))
                        .toIList(),
              ),
            )
            .sortedBy((team) => team.versionName)
            .toIList(),
  );
}
