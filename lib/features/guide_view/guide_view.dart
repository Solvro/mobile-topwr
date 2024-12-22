import "package:auto_route/auto_route.dart";
import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:flutter_svg/svg.dart";

import "../../../../widgets/my_error_widget.dart";
import "../../config/ui_config.dart";
import "../../gen/assets.gen.dart";
import "../../utils/context_extensions.dart";
import "../../utils/launch_url_util.dart";
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
            _GuideInfo(
              emailAddress: "kn.solvro@pwr.edu.pl",
              subject: context.localize.guide_subject_default_content,
            ),
          ].lock,
        ),
      _ => const Padding(
          padding: GuideViewConfig.gridPadding,
          child: DepartmentsViewLoading(),
        ),
    };
  }
}

class _GuideInfo extends ConsumerWidget {
  final String emailAddress;
  final String? subject;
  late final Uri emailLaunchUri;

  _GuideInfo({
    required this.emailAddress,
    this.subject,
  }) {
    emailLaunchUri = Uri(
      scheme: "mailto",
      path: emailAddress,
      query: "subject=$subject",
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return WideTileCard(
      title: context.localize.hi_student,
      subtitle: context.localize.guide_ideas_info,
      trailing: SizedBox.square(
        dimension: WideTileCardConfig.imageSize,
        child: SvgPicture.asset(
          Assets.svg.guideView.ideasBulb,
          width: WideTileCardConfig.imageSize,
          height: WideTileCardConfig.imageSize,
        ),
      ),
      onTap: () async {
        await ref.launch(emailLaunchUri.toString());
      },
    );
  }
}
