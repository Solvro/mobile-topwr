import "dart:async";

import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../../config/ui_config.dart";
import "../../../../theme/app_theme.dart";
import "../../../../utils/context_extensions.dart";
import "../../../../widgets/horizontal_symmetric_safe_area.dart";
import "../../../../widgets/my_error_widget.dart";
import "../../../../widgets/search_box_app_bar.dart";
import "../../../analytics/data/umami.dart";
import "../../../analytics/data/umami_events.dart";
import "../data/repository/sks_favourite_dishes_repository.dart";
import "sks_favourite_dishes_controller.dart";

import "widgets/sks_favourite_dishes_loading.dart";
import "widgets/sks_favourite_dishes_unwatched_section.dart";
import "widgets/sks_favourite_dishes_watched_section.dart";

@RoutePage()
class SksFavouriteDishesView extends ConsumerWidget {
  const SksFavouriteDishesView({super.key});

  static String localizedOfflineMessage(BuildContext context) {
    return context.localize.my_offline_error_message(context.localize.offline_sks_favourite_dishes);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncData = ref.watch(sksFavouriteDishesRepositoryProvider);
    return HorizontalSymmetricSafeAreaScaffold(
      appBar: SearchBoxAppBar(
        context,
        addLeadingPopButton: true,
        title: context.localize.sks_favourite_dishes,
        onQueryChanged: ref.watch(sksFavouriteDishesControllerProvider.notifier).onTextChanged,
        onSearchBoxTap: () {
          unawaited(ref.trackEvent(UmamiEvents.searchSksMenu));
        },
        primary: true,
      ),
      body: switch (asyncData) {
        AsyncError(:final error, :final stackTrace) => MyErrorWidget(error, stackTrace: stackTrace),
        AsyncData() => const _SksFavouriteDishesView(),
        _ => const SksFavouriteDishesViewLoading(),
      },
    );
  }
}

class _SksFavouriteDishesView extends StatelessWidget {
  const _SksFavouriteDishesView();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: SksMenuConfig.paddingMedium),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsetsGeometry.only(bottom: SksMenuConfig.paddingMedium),
            child: Text(context.localize.sks_favourite_dishes_subscribed, style: context.textTheme.titleOrange),
          ),
          const Expanded(child: SksFavouriteDishesWatchedSection()),
          Padding(
            padding: const EdgeInsetsGeometry.symmetric(vertical: SksMenuConfig.paddingMedium),
            child: Text(context.localize.sks_favourite_dishes_remaining, style: context.textTheme.titleOrange),
          ),
          const Expanded(flex: 2, child: SksFavouriteDishesUnwatchedSection()),
        ],
      ),
    );
  }
}
