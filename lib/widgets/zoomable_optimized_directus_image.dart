import "dart:ui";

import 'package:flutter/material.dart';
import "../theme/colors.dart";
import "optimized_directus_image.dart";

class ZoomableOptimizedDirectusImage extends StatefulWidget {
  const ZoomableOptimizedDirectusImage(
      this.imageUrl, {
        super.key,
        this.noShimmeringLoading = false,
        this.boxFit = BoxFit.cover,
        this.size,
      });

  final String? imageUrl;
  final bool noShimmeringLoading;
  final BoxFit boxFit;
  final Size? size;

  @override
  _ZoomableOptimizedDirectusImageState createState() => _ZoomableOptimizedDirectusImageState();
}

class _ZoomableOptimizedDirectusImageState extends State<ZoomableOptimizedDirectusImage> {
  bool _isFullScreen = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (_isFullScreen) {
          Navigator.of(context).pop();
        } else {
          _showFullScreenImage(context);
        }
      },
      child: OptimizedDirectusImage(
        widget.imageUrl,
        boxFit: widget.boxFit,
        noShimmeringLoading: widget.noShimmeringLoading,
      ),
    );
  }

  Future<void> _showFullScreenImage(BuildContext context) async {
    setState(() {
      _isFullScreen = true;
    });

    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => _FullScreenView(
          imageUrl: widget.imageUrl,
          noShimmeringLoading: widget.noShimmeringLoading,
          onTap: () {
            setState(() {
              _isFullScreen = false; // Close fullscreen on tap
            });
            Navigator.of(context).pop();
          },
        ),
      ),
    );
  }
}

class _FullScreenView extends StatelessWidget {
  final String? imageUrl;
  final bool noShimmeringLoading;

  final VoidCallback onTap;

  const _FullScreenView({
    required this.imageUrl,
    required this.noShimmeringLoading,
    required this.onTap,
  });

  @override
  Widget build(BuildContext build) {
    return Scaffold(
      backgroundColor: ColorsConsts.greyLight,
      body: GestureDetector(
          onTap: onTap,
          child:  Center(
            child: InteractiveViewer(
              minScale: 1,
              maxScale: 3,
              child: OptimizedDirectusImage(
                imageUrl,
                boxFit: BoxFit.contain,
                noShimmeringLoading: noShimmeringLoading
              ),
            )
          )
      )
    );
  }
}
