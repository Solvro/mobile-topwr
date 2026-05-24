import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";

import "../../../config/ui_config.dart";
import "../../../theme/app_theme.dart";
import "../../../utils/context_extensions.dart";
import "../../../widgets/detail_views/detail_view_app_bar.dart";
import "../../../widgets/my_error_widget.dart";
import "../data/repository/booths_repository.dart";
import "widgets/booth_tile.dart";
import "widgets/booth_tile_loading.dart";
import "widgets/booths_partner_footer.dart";
import "widgets/offline_booths_view.dart";

@RoutePage()
class BoothsView extends ConsumerWidget {
  const BoothsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final booths = ref.watch(boothsRepositoryProvider);

    return Scaffold(
      appBar: DetailViewAppBar(title: (text: context.localize.booths_title, context: context), leadingWidth: 80),
      body: booths.when(
        data: (booths) {
          if (booths.isEmpty) {
            return Center(child: Text(context.localize.booths_not_found));
          }

          return Column(
            children: [
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () => ref.refresh(boothsRepositoryProvider.future),
                  child: ListView.separated(
                    padding: GuideViewConfig.gridPadding,
                    itemCount: booths.length + (booths.length == 1 ? 1 : 0),
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: NavigationTabViewConfig.universalPadding),
                    itemBuilder: (context, index) {
                      if (index == booths.length) return const _MoreBoothsSoonMessage();
                      return BoothTile(booths[index]);
                    },
                  ),
                ),
              ),
              const BoothsPartnerFooter(),
            ],
          );
        },
        error: (error, stackTrace) => switch (error) {
          BoothsOfflineException() => const OfflineBoothsView(),
          _ => MyErrorWidget(error, stackTrace: stackTrace),
        },
        loading: () => Column(
          children: [
            Expanded(
              child: ListView.separated(
                padding: GuideViewConfig.gridPadding,
                itemCount: 3,
                separatorBuilder: (context, index) => const SizedBox(height: NavigationTabViewConfig.universalPadding),
                itemBuilder: (context, index) => const BoothTileLoading(),
              ),
            ),
            const BoothsPartnerFooter(),
          ],
        ),
      ),
    );
  }
}

class _MoreBoothsSoonMessage extends StatelessWidget {
  const _MoreBoothsSoonMessage();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        context.localize.booths_more_coming_soon,
        textAlign: TextAlign.center,
        style: context.textTheme.bodyLarge?.copyWith(color: context.colorScheme.tertiary),
      ),
    );
  }
}
