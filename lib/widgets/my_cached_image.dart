import 'package:cached_network_image/cached_network_image.dart';
import 'loading_widgets/shimmer_loading.dart';
import 'package:flutter/material.dart';
import '../features/splash_screen/widgets/flutter_splash_screen.dart';

//TODO: catch exception when imageUrl is empty

class MyCachedImage extends StatelessWidget {
  const MyCachedImage(this.imageUrl, {super.key});

  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl ?? "",
      fit: BoxFit.cover,
      placeholder: (context, url) =>
           Center(
            child: ShimmeringEffect(
          child: Container(
            color: Colors.white,
          ),
        )),
      errorWidget: (context, url, error) => const FlutterSplashScreen(),
    );
  }
}