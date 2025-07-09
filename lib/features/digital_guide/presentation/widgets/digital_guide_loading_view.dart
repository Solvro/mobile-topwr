import "package:flutter/material.dart";

import "../../../../config/ui_config.dart" show DetailViewsConfig, DigitalGuideConfig, GuideDetailViewConfig;
import "../../../../widgets/loading_widgets/shimmer_loading.dart";

class DigitalGuideLoadingView extends StatelessWidget {
  const DigitalGuideLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Shimmer(
        linearGradient: shimmerGradient,
        child: Column(
          children: [
            _DigitalGuideHeaderLoading(),
            _DigitalGuideTitleSectionLoading(),
            _DigitalGuideInfoSectionLoading(),
            Expanded(child: _DigitalGuideTilesLoading()),
          ],
        ),
      ),
    );
  }
}

class _DigitalGuideTitleSectionLoading extends StatelessWidget {
  const _DigitalGuideTitleSectionLoading();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: DigitalGuideConfig.borderRadiusBig),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ShimmerLoadingItem(
            child: Container(color: Colors.white, width: 100, height: DigitalGuideConfig.paddingBig),
          ),
          const SizedBox(height: DigitalGuideConfig.paddingSmall),
          ShimmerLoadingItem(
            child: Container(
              color: Colors.white,
              width: MediaQuery.of(context).size.width - 2 * DigitalGuideConfig.paddingBig,
              height: DigitalGuideConfig.paddingBig,
            ),
          ),
        ],
      ),
    );
  }
}

class _DigitalGuideHeaderLoading extends StatelessWidget {
  const _DigitalGuideHeaderLoading();

  @override
  Widget build(BuildContext context) {
    return ShimmerLoadingItem(
      child: Container(
        margin: const EdgeInsets.only(top: DigitalGuideConfig.borderRadiusBig),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(GuideDetailViewConfig.borderRadius),
        ),
        width: double.infinity,
        height: DetailViewsConfig.imageHeight,
      ),
    );
  }
}

class _DigitalGuideInfoSectionLoading extends StatelessWidget {
  const _DigitalGuideInfoSectionLoading();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: DigitalGuideConfig.borderRadiusBig),
      child: ShimmerLoadingItem(
        child: Container(color: Colors.white, width: double.infinity, height: 180),
      ),
    );
  }
}

class _DigitalGuideTilesLoading extends StatelessWidget {
  const _DigitalGuideTilesLoading();

  static const int itemCount = 5;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: DigitalGuideConfig.borderRadiusBig),
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: itemCount,
        itemBuilder: (context, index) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: GuideDetailViewConfig.paddingMedium),
            child: _LoadingTile(),
          );
        },
      ),
    );
  }
}

class _LoadingTile extends StatelessWidget {
  const _LoadingTile();

  @override
  Widget build(BuildContext context) {
    return ShimmerLoadingItem(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(GuideDetailViewConfig.borderRadius),
        ),
        width: double.infinity,
        height: DigitalGuideConfig.photoRowHeight,
      ),
    );
  }
}
