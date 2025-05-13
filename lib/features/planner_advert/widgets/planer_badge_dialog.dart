import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "../../../theme/app_theme.dart";
import "../repository/planner_advert_repository.dart";

class PlanerBadgeDialogContent extends ConsumerWidget {
  const PlanerBadgeDialogContent({super.key, required this.data});
  final PlannerAdvertContent data;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(data.title ?? "", style: context.textTheme.headline),
        const SizedBox(height: 12),
        Text(data.description, style: context.textTheme.lightTitle),
      ],
    );
  }
}
