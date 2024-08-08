import "package:riverpod_annotation/riverpod_annotation.dart";
import "../../../api_base/watch_query_adapter.dart";
import "../../../config/ttl_config.dart";
import "getGuideDetails.graphql.dart";

part "guide_detail_view_repository.g.dart";

typedef GuideDetails = Query$GetGuideDetails$FAQ_Types_by_id;
typedef _GetGuideDetails = WatchOptions$Query$GetGuideDetails;
typedef _Vars = Variables$Query$GetGuideDetails;
@riverpod
Stream<GuideDetails?> guideDetailsRepository(
  GuideDetailsRepositoryRef ref,
  String id,
) async* {
  final stream = ref.watchQueryWithCache(
    _GetGuideDetails(
      eagerlyFetchResults: true,
      variables: _Vars(id: id),
    ),
    TtlKey.guideDetailsRepository,
  );
  yield* stream.map((event) => event?.FAQ_Types_by_id);
}
