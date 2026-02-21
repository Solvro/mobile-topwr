import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../../config/ui_config.dart";
import "../../../../theme/app_theme.dart";
import "../../../departments/departments_view/data/models/department.dart";
import "../../science_clubs_filters/model/tags.dart";

class TagsSection extends ConsumerWidget {
  const TagsSection({super.key, required this.tags, this.department});

  final IList<Tag>? tags;
  final Department? department;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (tags == null || tags!.isEmpty) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        alignment: WrapAlignment.center,
        children: [
          for (final tag in tags!)
            Chip(
              label: Text(
                "#${tag.tag}",
                style: context.textTheme.bodyLarge?.copyWith(color: context.colorScheme.secondary),
              ),
              labelStyle: context.textTheme.bodyLarge,
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              visualDensity: VisualDensity.compact,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(ScienceClubsViewConfig.buttonBorderRadius),
                side: BorderSide(color: context.colorScheme.tertiary),
              ),
            ),
        ],
      ),
    );
  }
}
