import "dart:async";

import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../../../../theme/app_theme.dart";
import "../../../../utils/context_extensions.dart";
import "../../../../widgets/my_floating_action_button.dart";
import "../../../analytics/data/clarity.dart";
import "../../../analytics/data/clarity_events.dart";
import "../filters_controller.dart";
import "../filters_sheet.dart";

class FiltersFAB extends ConsumerWidget {
  const FiltersFAB({super.key, required this.bottomInsets});

  final double bottomInsets;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isActive = ref.watch(areFiltersEnabledProvider);

    final parentProvider = ProviderScope.containerOf(context);
    return MyFloatingActionButton(
      icon: Icons.tune,
      heroTag: "filters_fab",
      tooltip: context.localize.filters_fab_tooltip,
      onPressed: () async {
        unawaited(ref.trackEvent(ClarityEvents.openSciClubsFilterSheet));
        await showModalBottomSheet<void>(
          context: context,
          constraints: const BoxConstraints(),
          isScrollControlled: true,
          builder: (context) => UncontrolledProviderScope(container: parentProvider, child: const FiltersSheet()),
        );
      },
      bottomInset: bottomInsets,
      iconColor: !isActive ? context.colorTheme.orangePomegranade : context.colorTheme.whiteSoap,
      backgroundColor: isActive ? context.colorTheme.orangePomegranade : context.colorTheme.whiteSoap,
    );
  }
}
