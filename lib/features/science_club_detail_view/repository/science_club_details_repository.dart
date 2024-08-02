import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../api_base/watch_query_adapter.dart";
import "../../../config/ttl_config.dart";
import "getScienceClubDetails.graphql.dart";

part "science_club_details_repository.g.dart";

typedef ScienceClubDetails
    = Query$GetScienceClubDetails$Scientific_Circles_by_id;

typedef _Vars = Variables$Query$GetScienceClubDetails;
typedef _GetSciClubDetails = WatchOptions$Query$GetScienceClubDetails;

@riverpod
Stream<ScienceClubDetails?> scienceClubDetailsRepository(
  ScienceClubDetailsRepositoryRef ref,
  String id,
) async* {
  final stream = ref.watchQueryWithCache(
    _GetSciClubDetails(
      eagerlyFetchResults: true,
      variables: _Vars(id: id),
    ),
    TtlKey.scienceClubDetailsRepository,
  );
  yield* stream.map((event) => event?.Scientific_Circles_by_id);
}
