import "package:cached_network_image/cached_network_image.dart";
import "package:flutter/material.dart";
import "package:flutter_cache_manager/flutter_cache_manager.dart";

import "../config/ttl_config.dart";
import "../features/splash_screen/widgets/flutter_splash_screen.dart";
import "loading_widgets/shimmer_loading.dart";

class MyCachedImage extends StatelessWidget {
  const MyCachedImage(
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
  Widget build(BuildContext context) {
    if (imageUrl == null || imageUrl!.isEmpty) {
      return FlutterSplashScreen(size: size?.height);
    }

    return CachedNetworkImage(
      imageUrl: imageUrl ?? "",
      fit: boxFit,
      cacheManager: CacheManager(MyCachedImageConfig.cacheConfig),
      placeholder: noShimmeringLoading
          ? null
          : (context, url) => Center(
                child: ShimmeringEffect(
                  child: Container(
                    color: Colors.white,
                  ),
                ),
              ),
      errorWidget: (context, url, error) =>
          FlutterSplashScreen(size: size?.height),
      height: size?.height,
      width: size?.width,
    );
  }
}
