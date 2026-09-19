import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../../api_base_rest/cache/cache.dart";
import "../../../../api_base_rest/client/json.dart";
import "../../../../api_base_rest/shared_models/image_data.dart";
import "../../../../api_base_rest/translations/translate.dart";
import "../../../../config/env.dart";
import "../models/activity_days_stand_response.dart";
import "../models/activity_days_stands_response.dart";
import "activity_days_repository.dart";

part "activity_days_stands_repository.g.dart";

@riverpod
Future<IList<DasStand>> dasStandsRepository(Ref ref) async {
  final event = await ref.watch(activityDaysRepositoryProvider.future);
  if (event == null) return const IListConst([]);

  final url =
      "${Env.mainRestApiUrl}/das_stands?dasId=${event.id}&logo=true&floor=true&dasOrganization.logo=true&dasOrganization.studentOrganization=true";

  final response = await ref.getAndCacheDataWithTranslation(
    url,
    DasStandsListResponse.fromJson,
    extraValidityCheck: (_) => true,
    onRetry: ref.invalidateSelf,
  );
  final stands = response.castAsObject.data;
  return (await Future.wait(stands.map((stand) => _hydrateOrganizationLogo(ref, stand)))).toIList();
}

@riverpod
Future<DasStand> dasStandRepository(Ref ref, int id) async {
  final url =
      "${Env.mainRestApiUrl}/das_stands/$id?logo=true&floor=true&dasOrganization.logo=true&dasOrganization.studentOrganization=true";

  final response = await ref.getAndCacheDataWithTranslation(
    url,
    DasStandResponse.fromJson,
    extraValidityCheck: (_) => true,
    onRetry: ref.invalidateSelf,
  );
  return _hydrateOrganizationLogo(ref, response.castAsObject.data);
}

Future<DasStand> _hydrateOrganizationLogo(Ref ref, DasStand stand) async {
  final organization = stand.dasOrganization;
  if (organization == null) return stand;

  final logoKey = organization.logoKey;
  if (stand.logo != null || organization.logo != null || logoKey == null || logoKey.isEmpty) return stand;

  try {
    final response = await ref.getAndCacheData(
      "${Env.mainRestApiUrl}/files/$logoKey",
      ImageData.fromJson,
      extraValidityCheck: (_) => true,
    );
    return stand.copyWith(dasOrganization: organization.copyWith(logo: response.castAsObject));
  } on Object {
    return stand;
  }
}
