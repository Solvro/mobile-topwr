import "package:flutter/material.dart";

import "../my_cached_image.dart";

class SliverLogo extends StatelessWidget {
  const SliverLogo({
    super.key,
    required this.logoSize,
    required this.logoOpacity,
    required this.scaleFactor,
    required this.activeGradient,
    required this.logoImageUrl,
  });

  final double logoSize;
  final double logoOpacity;
  final double scaleFactor;
  final LinearGradient? activeGradient;
  final String? logoImageUrl;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: SizedBox.square(
        child: ListView(
          reverse: true,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            Opacity(
              opacity: logoOpacity,
              child: Card(
                elevation: 3,
                shape: const CircleBorder(),
                clipBehavior: Clip.antiAlias,
                child: Container(
                  width: logoSize,
                  height: logoSize,
                  decoration: BoxDecoration(
                    gradient: activeGradient,
                  ),
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: MyCachedImage(
                      size: Size.square(logoSize * scaleFactor),
                      logoImageUrl,
                      boxFit: BoxFit.scaleDown,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
