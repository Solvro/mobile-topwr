import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../api_base/query_adapter.dart";
import "../../../api_base/translations/temp_graphql_translate.dart";
import "../../../config/ttl_config.dart";
import "../models/about_us_details.dart";
import "getAboutUsDetails.graphql.dart";

part "about_us_repository.g.dart";

typedef AboutUs = Query$getAbousUsDetails$AboutUs;
typedef TeamVersion = Query$getAbousUsDetails$TeamVersions;
typedef TeamMember = Query$getAbousUsDetails$TeamVersion_Members;

@riverpod
Future<AboutUsDetails?> aboutUsRepository(Ref ref) async {
  final results = await ref.queryGraphql(Options$Query$getAbousUsDetails(), TtlKey.aboutUsRepository);
  if (results == null) return null;
  return AboutUsDetails(
    aboutUs: results.AboutUs?.copyWith(
      description: await ref.translateGraphQLMaybeString(results.AboutUs?.description),
    ),
    versions: await ref.translateGraphQLModelIList(
      results.TeamVersions.lock,
      (model) async => model.copyWith(name: await ref.translateGraphQLMaybeString(model.name)),
    ),
    teamMembers: await ref.translateGraphQLModelIList(
      results.TeamVersion_Members.lock,
      (model) async => model.copyWith(
        name: await ref.translateGraphQLMaybeString(model.name),
        subtitle: await ref.translateGraphQLMaybeString(model.subtitle),
      ),
    ),
  );
}
