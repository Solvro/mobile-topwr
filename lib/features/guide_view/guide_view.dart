import "package:auto_route/auto_route.dart";
import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:url_launcher/url_launcher_string.dart";

import "../../../../widgets/my_error_widget.dart";
import "../../config/ui_config.dart";
import "../../utils/context_extensions.dart";
import "../../widgets/search_box_app_bar.dart";
import "../../widgets/wide_tile_card.dart";
import "../departments_view/widgets/departments_view_loading.dart";
import "guide_view_controller.dart";
import "repository/guide_repository.dart";
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

    return switch (guideList) {
      AsyncError(:final error) => MyErrorWidget(error),
      AsyncValue(:final IList<GuidePost> value) => GuideGrid(
          children: [
            for (final item in value) GuideTile(item),
            _GuideInfo(),
          ].lock,
        ),
      _ => const Padding(
          padding: GuideViewConfig.gridPadding,
          child: DepartmentsViewLoading(),
        ),
    };
  }
}

class _GuideInfo extends StatelessWidget {
  final Uri emailLaunchUri = Uri(
    scheme: "mailto",
    path: "kn.solvro@pwr.edu.pl",
    query: "subject=Pomysł na rozwój ToPWR",
  );

  Future<void> _openUrl(url) async {
    if (await canLaunchUrlString(url)) {
      await launchUrlString(url);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.zero,
      child: WideTileCard(
        title: context.localize.hi_student,
        subtitle: context.localize.guide_ideas_info,
        secondSubtitle: context.localize.guide_click_here,
        onTap: () async => _openUrl(emailLaunchUri.toString()),
      ),
    );
  }
}
