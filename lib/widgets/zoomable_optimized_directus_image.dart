import "package:flutter/material.dart";
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
          backgroundColor: Colors.black.withOpacity(0.5),
          body: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: InteractiveViewer(
              minScale: 1,
              maxScale: 3,
              child: shouldHaveRectBackground? _showImageWithBackground(MediaQuery.of(context).size.shortestSide)
                                             : _showImage(),
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

  Center _showImageWithBackground(sideLength) => Center(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        width: sideLength,
        height: sideLength,
        child: _showImage(),
      ),
  );

  OptimizedDirectusImage _showImage() => OptimizedDirectusImage(
    imageUrl,
    boxFit: BoxFit.scaleDown,
  );
}
