import "dart:ui";

import 'package:flutter/material.dart';
import "../theme/colors.dart";
import "optimized_directus_image.dart";


class ZoomableOptimizedDirectusImage extends StatelessWidget {

  const ZoomableOptimizedDirectusImage(
      this.imageUrl, {
        super.key,
        this.noShimmeringLoading = false,
        this.boxFit = BoxFit.cover,
      });

  final String? imageUrl;
  final bool noShimmeringLoading;
  final BoxFit boxFit;

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
      MaterialPageRoute(
        builder: (newContext) =>
        Scaffold(
          backgroundColor: ColorsConsts.greyLight,
          body: GestureDetector(
            onTap: () {
              Navigator.of(newContext).pop();
            },
            child: InteractiveViewer(
              minScale: 1,
              maxScale: 3,
              child: OptimizedDirectusImage(
                imageUrl,
                boxFit: BoxFit.contain,
              ),
            ),
          ),
        ),
        fullscreenDialog: true,
      ),
    );
  }
}