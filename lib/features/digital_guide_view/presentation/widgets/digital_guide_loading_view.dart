import "package:flutter/material.dart";
import "../../../../config/ui_config.dart" show DetailViewsConfig, GuideDetailViewConfig;
import "../../../../widgets/loading_widgets/shimmer_loading.dart";

class DigitalGuideLoadingView extends StatelessWidget {
  const DigitalGuideLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Shimmer(
      linearGradient: shimmerGradient,
      child: Column(
        children: [
          _DigitalGuideHeaderLoading(),
          _DigitalGuideTitleSectionLoading(),
          _DigitalGuideInfoSectionLoading(),
          Expanded(
            child: _DigitalGuideTilesLoading(),
          ),
        ],
      ),
    );
  }
}

class _DigitalGuideTitleSectionLoading extends StatelessWidget {
  const _DigitalGuideTitleSectionLoading();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ShimmerLoadingItem(
            child: Container(
              color: Colors.white,
              width: 100,
              height: 28,
            ),
          ),
          const SizedBox(height: 8),
          ShimmerLoadingItem(
            child: Container(
              color: Colors.white,
              width: 250,
              height: 22,
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
        margin: const EdgeInsets.only(top: 16.0),
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
      padding: const EdgeInsets.only(top: 16.0),
      child: ShimmerLoadingItem(
        child: Container(
          color: Colors.white,
          width: double.infinity,
          height: 180,
        ),
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
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
        height: 70,
      ),
    );
  }
}
