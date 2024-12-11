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
  double _scale = 1.0;
  bool _isFullScreen = false; // Track fullscreen state

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (_isFullScreen) {
          Navigator.of(context).pop(); // Close fullscreen if already opened
        } else {
          _showFullScreenImage(context); // Open fullscreen
        }
      },
      child: Transform.scale(
        scale: _scale,
        child: OptimizedDirectusImage(
          widget.imageUrl,
          boxFit: widget.boxFit,
          noShimmeringLoading: widget.noShimmeringLoading,
        ),
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
          initialScale: _scale,
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

class _FullScreenView extends StatefulWidget {
  final String? imageUrl;
  final double initialScale;
  final VoidCallback onTap;

  const _FullScreenView({
    required this.imageUrl,
    required this.initialScale,
    required this.onTap,
  });

  @override
  _FullScreenViewState createState() => _FullScreenViewState();
}

class _FullScreenViewState extends State<_FullScreenView> {
  double _scale;
  double _previousScale = 1.0;

  Offset offset = Offset.zero;
  Offset prevOffset = Offset.zero;

  _FullScreenViewState() : _scale = 1.0;

  @override
  void initState() {
    super.initState();
    _scale = widget.initialScale; // Start with the scale from the original widget
  }
  Offset initialFocalPoint = Offset.zero;
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size; // Screen dimensions
    final double screenWidth = screenSize.width;
    final double screenHeight = screenSize.height;

    return Scaffold(
      backgroundColor: ColorsConsts.greyLight,
      body: GestureDetector(
        onTap: widget.onTap,
        onScaleStart: (details) {
          _previousScale = _scale;
          prevOffset = offset;
          initialFocalPoint = details.focalPoint;
        },
        onScaleUpdate: (details) {
          setState(() {
            // Update scale
            double delta = _scale - clampDouble(_previousScale * details.scale, 1, 4);
            _scale = clampDouble(_previousScale * details.scale, 1, 4);

              offset += details.focalPointDelta - (offset - prevOffset)*delta;
            final double imageWidth = screenWidth * _scale;
            final double imageHeight = screenHeight * _scale;

            // Calculate the maximum offset based on scaled image size
            final double maxX = (imageWidth - screenWidth) / 2;
            final double maxY = (imageHeight - screenHeight) / 2;

            // Clamp offset to ensure the image remains within bounds
            offset = Offset(
              offset.dx.clamp(-maxX, maxX),
              offset.dy.clamp(-maxY, maxY),
            );
          });
        },
        onScaleEnd: (details) {
          _previousScale = _scale; // Finalize scale
        },
        child: Center(
          child: Transform.translate(
            offset: offset,
            child: Transform.scale(
              scale: _scale,
              child: OptimizedDirectusImage(
                widget.imageUrl,
                boxFit: BoxFit.contain,
                noShimmeringLoading: false,
              ),
            ),
          ),
        ),
      ),
    );
  }



}