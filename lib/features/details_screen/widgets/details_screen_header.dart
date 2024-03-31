import 'dart:math';
import 'package:flutter/material.dart';
import '../../../config.dart';
import '../../../theme/app_theme.dart';
import '../../../widgets/my_cached_image.dart';

class HeaderSection extends StatelessWidget {
  const HeaderSection(
      {super.key,
      required this.logoImageUrl,
      required this.title,
      required this.department,
      required this.backgroundImageUrl});

  final String logoImageUrl;
  final String backgroundImageUrl;
  final String title;
  final String department;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            SizedBox(
                height: 250,
                width: double.maxFinite,
                child: MyCachedImage(backgroundImageUrl)),
            Positioned(
              top: 185,
              child: Card(
                elevation: 3,
                shape: const CircleBorder(),
                child: SizedBox(
                    width: 130,
                    height: 130,
                    child: ClipOval(child: MyCachedImage(logoImageUrl))),
              ),
            ),
          ],
        ),
        const SizedBox(height: 84),
        Text(
          title,
          style: context.textTheme.headline,
          textAlign: TextAlign.center,
          maxLines: 2,
        ),
        const SizedBox(height: 12),
        Text(
          department,
          style: context.textTheme.body,
          textAlign: TextAlign.center,
        )
      ],
    );
  }
}

class SliverHeaderSection extends SliverPersistentHeaderDelegate {

  final double minTopBarHeight = 0;
  final double maxTopBarHeight = 250;

  final String logoImageUrl;
  final String backgroundImageUrl;

  SliverHeaderSection(
      {required this.logoImageUrl, required this.backgroundImageUrl});

  @override
  Widget build(
      BuildContext context,
      double shrinkOffset,
      bool overlapsContent,
      ) {
    var shrinkFactor = min(1, shrinkOffset / (maxExtent - minExtent));
    var shrinkFactorLogo = min(1, shrinkOffset / (DetailsScreenHeaderConfig.logoSize));

    var topBar = Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Container(
          color: context.colorTheme.whiteSoap,
          height:
          max(maxTopBarHeight * (1 - shrinkFactor * 1.45), minTopBarHeight),
          width: double.infinity,
          child: ListView(
            children: [
              MyCachedImage(
                backgroundImageUrl)
            ],
          )),
    );

    return Container(
      height: max(maxExtent - shrinkOffset, minExtent),
      alignment: Alignment.center,
      child: Stack(
        alignment: Alignment.center,
        fit: StackFit.loose,
        children: [
          if (shrinkFactor <= 0.5) topBar,
          Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: max(DetailsScreenHeaderConfig.logoSize * (1 - shrinkFactorLogo * 0.3), 0),
                height: max(DetailsScreenHeaderConfig.logoSize * (1 - shrinkFactorLogo * 0.3), 0),
                alignment: Alignment.center,
                child: Card(
                  elevation: 3,
                  shape: const CircleBorder(),
                  child: SizedBox(
                    width: DetailsScreenHeaderConfig.logoSize,
                    height: DetailsScreenHeaderConfig.logoSize,
                    child: ClipOval(
                        child: MyCachedImage(logoImageUrl)),
                  ),
                ),
              )),
          if (shrinkFactor > 0.5) topBar,
        ],
      ),
    );
  }

  @override
  double get maxExtent => 300;

  @override
  double get minExtent => 0;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}

