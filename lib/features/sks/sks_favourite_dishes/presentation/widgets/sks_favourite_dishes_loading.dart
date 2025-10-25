import "package:flutter/material.dart";

import "../../../../../config/ui_config.dart";
import "../../../../../widgets/loading_widgets/shimmer_loading.dart";
import "../../../sks_menu/presentation/widgets/sks_menu_view_loading.dart";

class SksFavouriteDishesViewLoading extends StatelessWidget {
  const SksFavouriteDishesViewLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return const Shimmer(
      linearGradient: shimmerGradient,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: SksMenuConfig.paddingMedium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _LoadingTitle(),
            Expanded(child: _WatchedSectionLoading()),
            _LoadingTitle(),
            Expanded(flex: 2, child: SksMenuTilesLoading()),
          ],
        ),
      ),
    );
  }
}

class _WatchedSectionLoading extends StatelessWidget {
  const _WatchedSectionLoading();

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 2,
      separatorBuilder: (_, _) => const SizedBox(height: SksMenuConfig.paddingMedium),
      itemBuilder: (_, _) => const _LoadingDishTile(),
    );
  }
}

class _LoadingTitle extends StatelessWidget {
  const _LoadingTitle();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: SksMenuConfig.paddingMedium),
      child: ShimmerLoadingItem(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(SksMenuConfig.borderRadius),
          ),
          width: double.infinity,
          height: 24,
        ),
      ),
    );
  }
}

class _LoadingDishTile extends StatelessWidget {
  const _LoadingDishTile();

  @override
  Widget build(BuildContext context) {
    return ShimmerLoadingItem(
      child: Container(
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(SksMenuConfig.borderRadius)),
        width: double.infinity,
        height: 50,
      ),
    );
  }
}
