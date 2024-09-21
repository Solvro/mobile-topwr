import "package:auto_route/auto_route.dart";
import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:wiredash/wiredash.dart";

import "../../../../widgets/my_error_widget.dart";
import "../../config/ui_config.dart";
import "../../config/wiredash.dart";
import "../../theme/app_theme.dart";
import "../../utils/context_extensions.dart";
import "../../widgets/search_box_app_bar.dart";
import "../analytics/show_feedback_tile.dart";
import "../departments_view/widgets/departments_view_loading.dart";
import "guide_view_controller.dart";
import "repository/guide_repository.dart";
import "widgets/about_us_section.dart";
import "widgets/guide_grid.dart";
import "widgets/guide_tile.dart";

@RoutePage()
class GuideView extends StatelessWidget {
  const GuideView({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      overrides: [
        searchGuideControllerProvider,
      ],
      child: const _GuideView(),
    );
  }
}

class _GuideView extends ConsumerWidget {
  const _GuideView();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: SearchBoxAppBar(
        context,
        title: context.localize.guide,
        onQueryChanged:
            ref.watch(searchGuideControllerProvider.notifier).onTextChanged,
        actions: const [_AppBarBugReportIconButton()],
      ),
      body: const _GuideViewContent(),
    );
  }
}

class _GuideViewContent extends ConsumerWidget {
  const _GuideViewContent();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final guideList = ref.watch(guideListControllerProvider);
    final isSomethingSearched = ref.watch(isSomethingSearchedProvider);

    return switch (guideList) {
      AsyncError(:final error) => MyErrorWidget(error),
      AsyncValue(:final IList<GuidePost> value) => GuideGrid(
          children: [
            if (!isSomethingSearched) const GuideAboutUsSection(),
            for (final item in value) GuideTile(item),
            if (!isSomethingSearched) const ShowFeedbackTile(),
          ].lock,
        ),
      _ => const Padding(
          padding: GuideViewConfig.gridPadding,
          child: DepartmentsViewLoading(),
        ),
    };
  }
}

class _AppBarBugReportIconButton extends StatelessWidget {
  const _AppBarBugReportIconButton();

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Wiredash.of(context).show(
          options: WiredashFeedbackOptions(
            labels: context.labels,
          ),
        );
      },
      icon: Icon(
        Icons.bug_report,
        color: context.colorTheme.blackMirage,
      ),
    );
  }
}
