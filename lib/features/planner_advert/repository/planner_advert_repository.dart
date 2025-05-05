import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../api_base/query_adapter.dart";
import "../../../api_base/translations/temp_graphql_translate.dart";
import "../../../config/ttl_config.dart";
import "getPlannerAdvertContent.graphql.dart";

part "planner_advert_repository.g.dart";

typedef PlannerAdvertContent = Query$GetPlannerAdvertContent$PlannerAdvert;

@riverpod
Future<PlannerAdvertContent?> plannerAdvertContentRepository(Ref ref) async {
  final results = await ref.queryGraphql(Options$Query$GetPlannerAdvertContent(), TtlKey.plannerAdvertRepository);

  return results?.PlannerAdvert?.copyWith(
    title: await ref.translateGraphQLMaybeString(results.PlannerAdvert?.title),
    description: await ref.translateGraphQLMaybeString(results.PlannerAdvert?.description),
    url: await ref.translateGraphQLMaybeString(results.PlannerAdvert?.url),
  );
}
