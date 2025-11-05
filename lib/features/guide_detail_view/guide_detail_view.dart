import "package:auto_route/auto_route.dart";
import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:intl/intl.dart";

import "../../config/ui_config.dart";
import "../../theme/app_theme.dart";
import "../../utils/context_extensions.dart";
import "../../widgets/date_chip.dart";
import "../../widgets/detail_views/detail_view_app_bar.dart";
import "../../widgets/loading_widgets/shimmer_loading.dart";
import "../../widgets/loading_widgets/simple_previews/preview_text_prototype.dart";
import "../../widgets/my_error_widget.dart";
import "../../widgets/my_expansion_tile.dart";
import "../../widgets/my_html_widget.dart";
import "../../widgets/zoomable_images.dart";
import "data/models/guide_details.dart";
import "data/repository/guide_details_repository.dart";
import "utils/get_the_latest_date.dart";
import "widgets/faq_expansion_tile.dart";
import "widgets/tooltip_on_click.dart";

@RoutePage()
class GuideDetailView extends StatelessWidget {
  const GuideDetailView({@PathParam("id") required this.id, super.key});

  final int id;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: context.localize.guide_detail_view_description,
      child: Scaffold(
        appBar: DetailViewAppBar(),
        body: _GuideDetailDataView(id: id),
      ),
    );
  }
}

class _GuideDetailDataView extends ConsumerWidget {
  final int id;

  const _GuideDetailDataView({required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(guideDetailsRepositoryProvider(id));

    return switch (state) {
      AsyncError(:final error, :final stackTrace) => MyErrorWidget(error, stackTrace: stackTrace),
      AsyncValue(:final GuideDetails value) => Builder(
        builder: (context) {
          final lastModifiedDate = context.getTheLatestUpdatedDateGuide(questions: value.guideQuestions);
          final IList<String> authorsNames = value.guideAuthors
              .where((e) => e.role.role == GuideAuthorRoleType.author)
              .map((a) => a.name)
              .toIList();
          final IList<String> redactorsNames = value.guideAuthors
              .where((e) => e.role.role == GuideAuthorRoleType.redactor)
              .map((r) => r.name)
              .toIList();

          return CustomScrollView(
            slivers: [
              SliverAppBar(
                excludeHeaderSemantics: true,
                expandedHeight: 254,
                flexibleSpace: Stack(
                  children: [
                    Semantics(
                      label: context.localize.article_image_semantics_label,
                      child: SizedBox(height: DetailViewsConfig.imageHeight, child: ZoomableRestApiImage(value.image, boxFit: BoxFit.fit)),
                    ),
                    Positioned(
                      top: GuideDetailViewConfig.paddingMedium,
                      right: GuideDetailViewConfig.paddingSmall,
                      child: Tooltip(
                        message: context.localize.last_modified,
                        child: TooltipOnTap(
                          message: context.localize.last_modified,
                          child: DateChip(date: lastModifiedDate),
                        ),
                      ),
                    ),
                  ],
                ),
                automaticallyImplyLeading: false,
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: MyHtmlWidget(value.description.isEmpty ? value.shortDesc : value.description),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.only(bottom: GuideDetailViewConfig.paddingLarge),
                sliver: SliverList.separated(
                  itemCount: value.guideQuestions.length,
                  itemBuilder: (context, index) {
                    final question = value.guideQuestions[index];
                    return FaqExpansionTile(title: question.title, description: question.answer);
                  },
                  separatorBuilder: (context, index) => const SizedBox(height: 8),
                ),
              ),

              SliverPadding(
                padding: const EdgeInsets.only(
                  bottom: GuideDetailViewConfig.bottomPadding,
                  left: GuideDetailViewConfig.paddingLarge,
                  right: GuideDetailViewConfig.paddingLarge,
                ),
                sliver: SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (authorsNames.isNotEmpty)
                        RichText(
                          textScaler: MediaQuery.textScalerOf(context),
                          text: TextSpan(
                            style: context.textTheme.bodyGrey,
                            children: [
                              TextSpan(text: "${context.localize.authors(authorsNames.length)}: "),
                              TextSpan(text: authorsNames.join(", "), style: context.textTheme.boldBody),
                            ],
                          ),
                        ),
                      if (redactorsNames.isNotEmpty)
                        RichText(
                          textScaler: MediaQuery.textScalerOf(context),
                          text: TextSpan(
                            style: context.textTheme.bodyGrey,
                            children: [
                              TextSpan(text: "${context.localize.redactors(redactorsNames.length)}: "),
                              TextSpan(text: redactorsNames.join(", "), style: context.textTheme.boldBody),
                            ],
                          ),
                        ),
                      Text(
                        "${context.localize.created_at} ${context.getTheLatesCreatedDateGuide(questions: value.guideQuestions, locale: context.locale)}",
                        style: context.textTheme.bodyGrey,
                        textAlign: TextAlign.end,
                      ),
                      Text(
                        "${context.localize.last_modified} ${DateFormat("dd.MM.yyyy", context.locale.countryCode).format(lastModifiedDate)}",
                        style: context.textTheme.bodyGrey,
                        textAlign: TextAlign.end,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
      _ => const _GuideDetailLoading(),
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
            child: Container(color: Colors.white, width: double.infinity, height: 300),
          ),
          Padding(
            padding: const EdgeInsets.all(GuideDetailViewConfig.paddingMedium),
            child: ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, _) {
                return ShimmerLoadingItem(child: PreviewTextPrototype(width: double.infinity));
              },
              separatorBuilder: (context, _) => const SizedBox(height: 8),
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
                separatorBuilder: (context, _) => const SizedBox(height: 8),
                itemCount: 3,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
