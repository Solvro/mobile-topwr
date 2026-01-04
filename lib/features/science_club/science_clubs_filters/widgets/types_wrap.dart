import "dart:async";

import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../../utils/context_extensions.dart";
import "../../../analytics/data/clarity.dart";
import "../../../analytics/data/clarity_events.dart";
import "../filters_controller.dart";
import "../filters_search_controller.dart";
import "../filters_sheet.dart";
import "../model/sci_club_type.dart";
import "filter_chip.dart";

class TypesWrap extends ConsumerWidget {
  const TypesWrap({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final types = ref.watch(typeFiltersFilteredProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (types.isNotEmpty) FiltersSectionHeader(context.localize.org_types),
        Consumer(
          builder: (context, ref, child) {
            final controller = ref.watch(selectedTypeControllerProvider.notifier);
            final selectedTypes = ref.watch(selectedTypeControllerProvider);

            return RepaintBoundary(
              child: Wrap(
                runSpacing: context.isTextScaledDown ? 0 : 8,
                children: [
                  for (final type in types)
                    MyFilterChip(
                      label: context.sciClubTypeDisplayName(type),
                      onTap: () {
                        unawaited(ref.trackEvent(ClarityEvents.selectSciClubFilterOrgType, value: type.name));
                        controller.toggleFilter(type);
                      },
                      selected: selectedTypes.contains(type),
                    ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
