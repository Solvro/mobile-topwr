import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../utils/context_extensions.dart";
import "../../../widgets/search_box_app_bar.dart";
import "../../science_clubs_filters/widgets/filters_fab.dart";
import "../controllers/science_clubs_view_controller.dart";

class SciClubsScaffold extends ConsumerWidget {
  const SciClubsScaffold({super.key, required this.child, this.showFab = true});
  final Widget? child;
  final bool showFab;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: SearchBoxAppBar(
        context,
        title: context.localize.study_circles,
        onQueryChanged: ref
            .watch(searchScienceClubsControllerProvider.notifier)
            .onTextChanged,
      ),
      floatingActionButton: showFab ? const FiltersFAB() : null,
      body: child,
    );
  }
}
