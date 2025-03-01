import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../../api_base/query_adapter.dart";
import "../../../../config/ttl_config.dart";
import "getScienceClubDetails.graphql.dart";

part "science_club_details_repository.g.dart";

typedef ScienceClubDetails = Query$GetScienceClubDetails$Scientific_Circles_by_id;

typedef _Vars = Variables$Query$GetScienceClubDetails;

@riverpod
Future<ScienceClubDetails?> scienceClubDetailsRepository(Ref ref, String id) async {
  final results = await ref.queryGraphql(
    Options$Query$GetScienceClubDetails(variables: _Vars(id: id)),
    TtlKey.scienceClubDetailsRepository,
  );
  return results?.Scientific_Circles_by_id;
}
