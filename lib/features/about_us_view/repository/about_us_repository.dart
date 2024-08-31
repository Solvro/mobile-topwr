import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../api_base/query_adapter.dart";
import "../../../config/ttl_config.dart";
import "../models/about_us_details.dart";
import "getAboutUsDetails.graphql.dart";

part "about_us_repository.g.dart";

typedef AboutUs = Query$getAbousUsDetails$AboutUs;
typedef AboutUsTeam = Query$getAbousUsDetails$AboutUs_Team;

@riverpod
Future<AboutUsDetails?> aboutUsRepository(AboutUsRepositoryRef ref) async {
  final results = await ref.queryGraphql(
    Options$Query$getAbousUsDetails(),
    TtlKey.aboutUsRepository,
  );
  if (results == null) return null;
  return AboutUsDetails(
    aboutUs: results.AboutUs,
    aboutUsTeam: results.AboutUs_Team,
  );
}
