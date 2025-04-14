import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../api_base/query_adapter.dart";
import "../../../api_base/translations/temp_graphql_translate.dart";
import "../../../config/ttl_config.dart";
import "getGuideDetails.graphql.dart";

part "guide_detail_view_repository.g.dart";

typedef GuideDetails = Query$GetGuideDetails$FAQ_Types_by_id;
typedef _Vars = Variables$Query$GetGuideDetails;

@riverpod
Future<GuideDetails?> guideDetailsRepository(Ref ref, String id) async {
  final results = await ref.queryGraphql(
    Options$Query$GetGuideDetails(variables: _Vars(id: id)),
    TtlKey.guideDetailsRepository,
  );
  final post = results?.FAQ_Types_by_id;
  return post?.copyWith(
    name: await ref.translateGraphQLMaybeString(post.name),
    description: await ref.translateGraphQLMaybeString(post.description),
    questions: await ref.translateGraphQLModelList(
      post.questions ?? [],
      (question) async => question?.copyWith(
        FAQ_id: question.FAQ_id?.copyWith(
          answer: await ref.translateGraphQLMaybeString(question.FAQ_id?.answer),
          question: await ref.translateGraphQLMaybeString(question.FAQ_id?.question),
        ),
      ),
    ),
  );
}
