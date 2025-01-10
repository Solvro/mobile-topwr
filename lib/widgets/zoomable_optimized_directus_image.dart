import "package:flutter/material.dart";

import "../theme/colors.dart";
import "optimized_directus_image.dart";

class ZoomableOptimizedDirectusImage extends StatelessWidget {
  const ZoomableOptimizedDirectusImage(
    this.imageUrl, {
    super.key,
    this.noShimmeringLoading = false,
    this.boxFit = BoxFit.cover,
    this.shouldHaveRectBackground = false,
  });

  final String? imageUrl;
  final bool noShimmeringLoading;
  final BoxFit boxFit;
  final bool shouldHaveRectBackground;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await _showFullScreenImage(context);
      },
      child: OptimizedDirectusImage(
        imageUrl,
        boxFit: boxFit,
        noShimmeringLoading: noShimmeringLoading,
      ),
    );
  }

  Future<void> _showFullScreenImage(BuildContext context) async {
    await Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false,
        pageBuilder: (context, animation, secondaryAnimation) => Scaffold(
          backgroundColor: Colors.black.withAlpha(127),
          body: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: InteractiveViewer(
              minScale: 1,
              maxScale: 3,
              child: shouldHaveRectBackground
                  ? Center(
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Container(
                          decoration: BoxDecoration(
                            color: ColorsConsts.greyLight,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          width: MediaQuery.sizeOf(context).shortestSide,
                          height: MediaQuery.sizeOf(context).shortestSide,
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: OptimizedDirectusImage(
                              imageUrl,
                              boxFit: BoxFit.scaleDown,
                              noShimmeringLoading: true,
                            ),
                          ),
                        ),
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.all(10),
                      child: OptimizedDirectusImage(
                        imageUrl,
                        boxFit: BoxFit.scaleDown,
                        noShimmeringLoading: true,
                      ),
                    ),
            ),
          ),
        ),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
      ),
    );
  }
}
