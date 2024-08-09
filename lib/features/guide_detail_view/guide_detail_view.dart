import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../api_base/directus_assets_url.dart";
import "../../config/ui_config.dart";
import "../../utils/context_extensions.dart";
import "../../widgets/detail_views/detail_view_app_bar.dart";
import "../../widgets/loading_widgets/shimmer_loading.dart";
import "../../widgets/loading_widgets/simple_previews/preview_text_prototype.dart";
import "../../widgets/my_cached_image.dart";
import "../../widgets/my_error_widget.dart";
import "../../widgets/my_html_widget.dart";
import "repository/guide_detail_view_repository.dart";
import "widgets/my_expansion_tile.dart";

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
      AsyncLoading() => const _GuideDetailLoading(),
      AsyncError(:final error) => MyErrorWidget(error),
      AsyncValue(:final value) => CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 254,
              flexibleSpace: SizedBox(
                height: 254,
                child: MyCachedImage(
                  value?.cover?.filename_disk?.directusUrl,
                ),
              ),
              automaticallyImplyLeading: false,
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding:
                    const EdgeInsets.all(GuideDetailViewConfig.paddingMedium),
                child: MyHtmlWidget(
                  value?.description ?? "",
                  textStyle: context.textTheme.body.copyWith(fontSize: 16),
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.only(
                bottom: GuideDetailViewConfig.paddingLarge,
              ),
              sliver: SliverList.separated(
                itemCount: value?.questions?.length ?? 0,
                itemBuilder: (context, index) {
                  final question = value?.questions?[index]?.FAQ_id;
                  return MyExpansionTile(
                    title: question?.question ?? "",
                    description: question?.answer ?? "",
                  );
                },
                separatorBuilder: (context, index) => const SizedBox(height: 8),
              ),
            ),
          ],
        ),
    };
  }
}

class _GuideDetailLoading extends StatelessWidget {
  const _GuideDetailLoading();

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      linearGradient: shimmerGradient,
      child: ListView(
        physics: const NeverScrollableScrollPhysics(),
        children: [
          ShimmerLoadingItem(
            child: Container(
              color: Colors.white,
              width: double.infinity,
              height: 300,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(GuideDetailViewConfig.paddingMedium),
            child: ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, _) {
                return ShimmerLoadingItem(
                  child: PreviewTextPrototype(
                    width: double.infinity,
                  ),
                );
              },
              separatorBuilder: (context, _) => const SizedBox(
                height: 8,
              ),
              itemCount: 5,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(GuideDetailViewConfig.paddingMedium),
            child: ShimmerLoadingItem(
              child: ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, _) {
                  return const MyExpansionTileLoading();
                },
                separatorBuilder: (context, _) => const SizedBox(
                  height: 8,
                ),
                itemCount: 3,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
