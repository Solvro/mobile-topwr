import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../../utils/context_extensions.dart";
import "../../../../widgets/horizontal_symmetric_safe_area.dart";
import "../../../../widgets/search_box_app_bar.dart";
import "../../science_clubs_filters/widgets/filters_fab.dart";
import "../controllers/science_clubs_view_controller.dart";

class SciClubsScaffold extends ConsumerWidget {
  const SciClubsScaffold({super.key, required this.child, this.showFab = true,this.appBarActions});
  final Widget? child;
  final bool showFab;
  final List<Widget>? appBarActions;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return HorizontalSymmetricSafeAreaScaffold(
      appBar: SearchBoxAppBar(
        addLeadingPopButton: true,
        primary: true,
        context,
        title: context.localize.study_circles,
        onQueryChanged: ref.watch(searchScienceClubsControllerProvider.notifier).onTextChanged,
        actions: appBarActions
      ),
      body: Stack(
        children: [
          if (child != null) child!,
          if (showFab)
            Positioned(
              right: 16, // the left view padding is applied globally
              bottom: MediaQuery.viewPaddingOf(context).bottom + 16,
              child: const FiltersFAB(),
            ),
        ],
      ),
    );
  }
}
