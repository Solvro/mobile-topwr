import "package:flutter/material.dart";

import "../../../../../config/ui_config.dart";
import "../../../../../widgets/loading_widgets/scrolable_loader_builder.dart";
import "../../../../../widgets/loading_widgets/shimmer_loading.dart";

class SksMenuViewLoading extends StatelessWidget {
  const SksMenuViewLoading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Shimmer(
      linearGradient: shimmerGradient,
      child: Column(
        children: [
          _SksMenuHeaderLoading(),
          Expanded(
            child: _SksMenuTilesLoading(),
          ),
        ],
      ),
    );
  }
}

class _SksMenuTilesLoading extends StatelessWidget {
  const _SksMenuTilesLoading();
  static const groupElements = 3;
  @override
  Widget build(BuildContext context) {
    return ScrollableLoaderBuilder(
      itemsSpacing: 4,
      mainAxisItemSize: 14,
      scrollDirection: Axis.vertical,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding:
              const EdgeInsets.symmetric(vertical: SksMenuConfig.paddingMedium),
          child: ShimmerLoadingItem(
            child: ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, _) {
                return const _LoadingTitle();
              },
              separatorBuilder: (context, _) => const SizedBox(),
              itemCount: groupElements,
            ),
          ),
        );
      },
    );
  }
}

class _SksMenuHeaderLoading extends StatelessWidget {
  const _SksMenuHeaderLoading();
  @override
  Widget build(BuildContext context) {
    return ShimmerLoadingItem(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(SksMenuConfig.borderRadius),
        ),
        width: double.infinity,
        height: 250,
      ),
    );
  }
}

class _LoadingTitle extends StatelessWidget {
  const _LoadingTitle();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        SksMenuConfig.paddingLarge,
        0,
        SksMenuConfig.paddingLarge,
        SksMenuConfig.paddingMedium,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(SksMenuConfig.borderRadius),
        ),
        width: double.infinity,
        height: 50,
      ),
    );
  }
}
