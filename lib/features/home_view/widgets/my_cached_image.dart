import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';

import '../../../widgets/loading_widget.dart';
import '../../splash_screen/widgets/flutter_splash_screen.dart';

class MyCachedImage extends StatelessWidget {
  const MyCachedImage(this.imageUrl, {super.key});
  final String? imageUrl;
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl ?? "",
      fit: BoxFit.cover,
      placeholder: (context, url) => const LoadingWidget(),
      errorWidget: (context, url, error) => const FlutterSplashScreen(),
    );
  }
}