import "dart:async";

import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../../../../theme/app_theme.dart";
import "../../../../utils/context_extensions.dart";
import "../../../analytics/data/umami.dart";
import "../../../analytics/data/umami_events.dart";
import "../filters_controller.dart";
import "../filters_sheet.dart";

class FiltersFAB extends ConsumerWidget {
  const FiltersFAB({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isActive = ref.watch(areFiltersEnabledProvider);

    final parentProvider = ProviderScope.containerOf(context);
    return FloatingActionButton(
      tooltip: context.localize.filters_fab_tooltip,
      onPressed: () async {
        unawaited(ref.trackEvent(UmamiEvents.openSciClubsFilterSheet));
        await showModalBottomSheet<void>(
          context: context,
          constraints: const BoxConstraints(),
          isScrollControlled: true,
          builder: (context) => UncontrolledProviderScope(container: parentProvider, child: const FiltersSheet()),
        );
      },
      backgroundColor: isActive ? context.colorTheme.orangePomegranade : context.colorTheme.whiteSoap,
      child: Semantics(
        label: context.localize.filters_fab_tooltip,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: Icon(
                Icons.tune,
                color: !isActive ? context.colorTheme.orangePomegranade : context.colorTheme.whiteSoap,
              ),
            ),
            if (isActive)
              Positioned(top: 4, right: 4, child: Icon(Icons.circle, size: 8, color: context.colorTheme.whiteSoap)),
          ],
        ),
      ),
    );
  }
}
