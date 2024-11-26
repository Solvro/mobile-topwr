import "package:flutter/material.dart";
import "package:flutter_svg/svg.dart";

import "../../../gen/assets.gen.dart";
import "../../../theme/app_theme.dart";

class LogoAppBar extends AppBar {
  /// AppBar with ToPWR colorful logo
  LogoAppBar(
    BuildContext context, {
    super.key,
    double? logoSize,
    double toolbarHeight = kToolbarHeight,
    super.actions,
  }) : super(
          title: AppBarLogo(logoSize: logoSize),
          centerTitle: false,
          titleSpacing: 0,
          backgroundColor: context.colorTheme.whiteSoap,
          scrolledUnderElevation: 0,
          automaticallyImplyLeading: false,
          toolbarHeight: toolbarHeight,
        );
}

class AppBarLogo extends StatelessWidget {
  /// ToPWR Appbar svg colorful themed logo
  const AppBarLogo({
    super.key,
    this.logoSize,
  });

  final double? logoSize;
  static Future<void> precacheImageIfAbsent() async {
    final loader = SvgAssetLoader(Assets.svg.logoAppBar);
    await svg.cache.putIfAbsent(
      loader.cacheKey(null),
      () => loader.loadBytes(null),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
      child: SvgPicture.asset(
        Assets.svg.logoAppBar,
        width: logoSize,
        height: logoSize,
      ),
    );
  }
}
