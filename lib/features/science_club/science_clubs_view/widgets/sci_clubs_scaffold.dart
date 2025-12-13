import "dart:async";

import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../../utils/context_extensions.dart";
import "../../../../widgets/horizontal_symmetric_safe_area.dart";
import "../../../../widgets/search_box_app_bar.dart";
import "../../../analytics/data/clarity.dart";
import "../../../analytics/data/clarity_events.dart";
import "../../science_clubs_filters/widgets/filters_fab.dart";
import "../controllers/science_clubs_view_controller.dart";

class SciClubsScaffold extends ConsumerWidget {
  const SciClubsScaffold({super.key, required this.child, this.showFab = true, this.appBarActions, this.initialQuery});
  final Widget? child;
  final bool showFab;
  final String? initialQuery;
  final List<Widget>? appBarActions;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (initialQuery != null && initialQuery!.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref.read(searchScienceClubsControllerProvider.notifier).onTextChanged(initialQuery!);
      });
    }

    return HorizontalSymmetricSafeAreaScaffold(
      appBar: SearchBoxAppBar(
        addLeadingPopButton: true,
        primary: true,
        context,
        initialQuery: initialQuery,
        title: context.localize.study_circles,
        onQueryChanged: ref.watch(searchScienceClubsControllerProvider.notifier).onTextChanged,
        actions: appBarActions,
        onSearchBoxTap: () {
          unawaited(ref.trackEvent(ClarityEvents.searchSciClub));
        },
      ),
      body: child ?? const SizedBox.shrink(),
      extraFabs: const [FiltersFAB()],
    );
  }
}
