import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../api_base/query_adapter.dart";
import "../../../config/ttl_config.dart";
import "getGuideDetails.graphql.dart";

part "guide_detail_view_repository.g.dart";

typedef GuideDetails = Query$GetGuideDetails$FAQ_Types_by_id;
typedef _Vars = Variables$Query$GetGuideDetails;

@riverpod
Future<GuideDetails?> guideDetailsRepository(
  GuideDetailsRepositoryRef ref,
  String id,
) async {
  final results = await ref.queryGraphql(
    Options$Query$GetGuideDetails(
      variables: _Vars(id: id),
    ),
    TtlKey.guideDetailsRepository,
  );
  return results?.FAQ_Types_by_id;
}
