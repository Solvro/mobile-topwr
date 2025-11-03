import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../../config/ui_config.dart";
import "../../../../theme/app_theme.dart";
import "../../../../theme/hex_color.dart";
import "../../../../utils/colors_sort.dart";
import "../../../../utils/context_extensions.dart";
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

    // Use department gradient colors if available, otherwise default orange
    final backgroundColor = department != null ? _getGradientColor(department!) : context.colorTheme.orangePomegranade;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(context.localize.categories, style: context.textTheme.headline),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final tag in tags!)
                Chip(
                  label: Text(tag.tag),
                  labelStyle: context.textTheme.body.copyWith(color: Colors.white, fontSize: 12),
                  backgroundColor: backgroundColor,
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  visualDensity: VisualDensity.compact,
                  side: BorderSide.none,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(ScienceClubsViewConfig.buttonBorderRadius),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  // Helper method to get a single color from department gradient
  Color _getGradientColor(Department department) {
    final gradientColors = [HexColor(department.gradientStart), HexColor(department.gradientStop)]..sortByLightness();
    // Use the first color (darker one after sorting)
    return gradientColors.first;
  }
}
