import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart";

import "../../api_base/directus_assets_url.dart";
import "../../config/ui_config.dart";
import "../../theme/app_theme.dart";
import "../../utils/context_extensions.dart";
import "../../widgets/detail_views/detail_view_app_bar.dart";
import "../../widgets/my_cached_image.dart";
import "../../widgets/my_error_widget.dart";
import "repository/guide_detail_view_repository.dart";

@RoutePage()
class GuideDetailView extends StatelessWidget {
  const GuideDetailView({
    @PathParam("id") required this.id,
    super.key,
  });

  final String id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DetailViewAppBar(context, title: context.localize.guide),
      body: _GuideDetailDataView(id: id),
    );
  }
}

class _GuideDetailDataView extends ConsumerWidget {
  final String id;

  const _GuideDetailDataView({required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(guideDetailsRepositoryProvider(id));
    return switch (state) {
      AsyncLoading() => const Placeholder(),
      AsyncError(:final error) => MyErrorWidget(error),
      AsyncValue(:final value) => ListView(
          children: [
            MyCachedImage(value?.cover?.filename_disk?.directusUrl),
            Padding(
              padding:
                  const EdgeInsets.all(GuideDetailViewConfig.paddingMedium),
              child: HtmlWidget(
                value?.description ?? "",
                textStyle: context.textTheme.body.copyWith(fontSize: 16),
              ),
            ),
            ListView.separated(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              padding: const EdgeInsets.only(
                bottom: GuideDetailViewConfig.paddingLarge,
              ),
              itemCount: value?.questions?.length ?? 0,
              itemBuilder: (context, index) {
                final question = value?.questions?[index]?.FAQ_id;
                return _MyExpansionTile(
                  title: question?.question ?? "",
                  description: question?.answer ?? "",
                );
              },
              separatorBuilder: (context, index) => const SizedBox(
                height: 8,
              ),
            ),
          ],
        )
    };
  }
}

class _MyExpansionTile extends StatelessWidget {
  final String title;
  final String description;

  const _MyExpansionTile({
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: GuideDetailViewConfig.paddingMedium,
      ),
      child: ExpansionTile(
        title: Text(title, style: context.textTheme.title),
        backgroundColor: context.colorTheme.greyLight,
        collapsedBackgroundColor: context.colorTheme.greyLight,
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(GuideDetailViewConfig.borderRadius),
        ),
        collapsedShape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(GuideDetailViewConfig.borderRadius),
        ),
        iconColor: context.colorTheme.orangePomegranade,
        collapsedIconColor: context.colorTheme.orangePomegranade,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: GuideDetailViewConfig.paddingSmall,
            ),
            child: ListTile(
              title: Text(
                description,
                style: context.textTheme.body.copyWith(fontSize: 14),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
