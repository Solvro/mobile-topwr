import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../api_base_rest/shared_models/image_data.dart";
import "../../../config/ui_config.dart";
import "../../../utils/context_extensions.dart";
import "../../../utils/launch_url_util.dart";
import "../../../utils/unwaited_microtask.dart";
import "../../../widgets/big_preview_card.dart";
import "../../../widgets/my_error_widget.dart";
import "../../../widgets/subsection_header.dart";
import "../../home_view/widgets/loading_widgets/big_scrollable_section_loading.dart";
import "../../home_view/widgets/paddings.dart";
import "../../navigator/utils/navigation_commands.dart";
import "../data/models/newsfeed_models.dart";
import "../data/repository/newsfeed_repository.dart";

class NewsSection extends ConsumerWidget {
  const NewsSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => Column(
    children: [
      SubsectionHeader(
        title: context.localize.news,
        actionTitle: context.localize.list,
        onClick: () => ref.navigateNewsfeed(),
      ),
      const _NewsList(),
    ],
  );
}

class _NewsList extends ConsumerWidget {
  const _NewsList();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(newsfeedRepositoryProvider);
    const textHeight = 260.0;
    final cardHeight = BigPreviewCardConfig.cardHeight - textHeight + context.textScaler.scale(textHeight);
    return switch (state) {
      AsyncError(:final error, :final stackTrace) => MyErrorWidget(error, stackTrace: stackTrace),
      AsyncValue(:final IList<Article> value) => SmallHorizontalPadding(
        child: SizedBox(height: cardHeight, child: _NewsDataList(value)),
      ),
      _ => Padding(
        padding: const EdgeInsets.only(left: HomeViewConfig.paddingMedium, top: HomeViewConfig.paddingMedium * 2),
        child: SizedBox(height: cardHeight - HomeViewConfig.paddingMedium, child: const BigScrollableSectionLoading()),
      ),
    };
  }
}

class _NewsDataList extends ConsumerWidget {
  const _NewsDataList(this.news);

  final IList<Article> news;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView.builder(
      cacheExtent: 4,
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemCount: news.length,
      itemBuilder: (BuildContext context, int index) {
        final article = news[index];
        final articleCard = _ArticleCard(article: article);
        if (index != news.length - 1) {
          return MediumLeftPadding(child: articleCard);
        } else {
          return MediumHorizontalPadding(child: articleCard);
        }
      },
    );
  }
}

class _ArticleCard extends ConsumerWidget {
  const _ArticleCard({required this.article});

  final Article article;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BigPreviewCard(
      title: article.title,
      shortDescription: article.previewText,
      imageData: ImageData(url: article.imageLink),
      onClick: () {
        unwaitedMicrotask(() => ref.launch(article.url));
      },
    );
  }
}
