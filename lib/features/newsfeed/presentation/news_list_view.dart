import "package:auto_route/auto_route.dart";
import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:solvro_translator_core/solvro_translator_core.dart";

import "../../../../widgets/my_error_widget.dart";
import "../../../config/ui_config.dart";
import "../../../config/url_config.dart";
import "../../../services/translations_service/data/preferred_lang_repository.dart";
import "../../../utils/context_extensions.dart";
import "../../../utils/launch_url_util.dart";
import "../../../widgets/detail_views/detail_view_app_bar.dart";
import "../../../widgets/my_text_button.dart";
import "../../../widgets/wide_tile_card.dart";
import "../../departments/departments_view/widgets/departments_view_loading.dart";
import "../../guide_view/widgets/guide_grid.dart";
import "../data/models/newsfeed_models.dart";
import "../data/repository/newsfeed_repository.dart";

@RoutePage()
class NewsfeedView extends StatelessWidget {
  const NewsfeedView({super.key});

  static String localizedOfflineMessage(BuildContext context) {
    return context.localize.my_offline_error_message(context.localize.news);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DetailViewAppBar(title: (text: context.localize.news, context: context)),
      body: const _NewsfeedViewContent(),
    );
  }
}

class _NewsfeedViewContent extends ConsumerWidget {
  const _NewsfeedViewContent();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final newsfeed = ref.watch(newsfeedRepositoryProvider);

    return switch (newsfeed) {
      AsyncError(:final error, :final stackTrace) => MyErrorWidget(error, stackTrace: stackTrace),
      AsyncValue(:final IList<Article> value) => GuideGrid(
        children: [
          for (final item in value) NewsTile(item),
          Align(
            alignment: Alignment.topCenter,
            child: SizedBox(
              width: double.infinity,
              child: MyTextButton(
                actionTitle: context.localize.read_more_arrows,
                onClick: () => ref.launch(
                  ref.watch(preferredLanguageRepositoryProvider).valueOrNull != SolvroLocale.pl
                      ? UrlConfig.newsfeedUrlENG
                      : UrlConfig.newsfeedUrlPL,
                ),
              ),
            ),
          ),
        ].lock,
      ),
      _ => const Padding(padding: GuideViewConfig.gridPadding, child: DepartmentsViewLoading()),
    };
  }
}

class NewsTile extends ConsumerWidget {
  const NewsTile(this.item, {super.key});
  final Article item;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PhotoTrailingWideTileCard(
      context,
      title: item.title,
      subtitle: item.previewText,
      directusPhotoUrl: item.imageLink,
      onTap: () => ref.launch(item.url),
      crossAxisAlignment: CrossAxisAlignment.stretch,
    );
  }
}
