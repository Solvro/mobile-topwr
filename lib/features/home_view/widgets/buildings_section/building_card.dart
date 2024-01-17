import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../theme/app_theme.dart';
import '../../../../theme/hex_color.dart';
import '../../../../widgets/loading_widget.dart';
import '../../../splash_screen/widgets/flutter_splash_screen.dart';

class BuildingCard extends StatelessWidget {
  const BuildingCard({
    Key? key,
    required this.onTap,
    required this.buildingName,
    required this.imageUrl,
  }) : super(key: key);

  final VoidCallback onTap;
  final String buildingName;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 16),
      width: 120,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Stack(
          fit: StackFit.expand,
          children: [
            CachedNetworkImage(
              imageUrl: imageUrl,
              fit: BoxFit.cover,
              placeholder: (context, url) => const LoadingWidget(),
              errorWidget: (context, url, error) => const FlutterSplashScreen(),
            ),
            Positioned.fill(
              child: imageUrl == ""
                  ? Container()
                  : Container(
                      decoration: BoxDecoration(
                        gradient: context.colorTheme.buildingsGradient,
                      ),
                    ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 16, top: 84),
              child: Text(buildingName,
                  style: context.textTheme.headlineWhite.copyWith(shadows: [
                    const Shadow(
                      color: HexColor.consts(0x6621334D66),
                      blurRadius: 4.0,
                      offset: Offset(0.0, 2.0),
                    ),
                  ])),
            ),
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: onTap,
                child: Container(
                  color: Colors.transparent,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
