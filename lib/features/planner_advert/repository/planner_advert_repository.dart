import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

part "planner_advert_repository.g.dart";

typedef PlannerAdvertContent = ({
  String? title,
  String description,
  String? url,
  String? backgroundColor,
  String? textColor,
  String? titleColor,
  bool isEnabled,
});

@riverpod
Future<PlannerAdvertContent?> plannerAdvertContentRepository(Ref ref) async {
  return null;
  // TODO(simon-the-shark): implement new banner from REST API
  // final results = await ref.queryGraphql(Options$Query$GetPlannerAdvertContent(), TtlKey.plannerAdvertRepository);

  // return results?.PlannerAdvert?.copyWith(
  //   title: await ref.translateGraphQLMaybeString(results.PlannerAdvert?.title),
  //   description: await ref.translateGraphQLMaybeString(results.PlannerAdvert?.description),
  //   url: await ref.translateGraphQLMaybeString(results.PlannerAdvert?.url),
  // );
}
