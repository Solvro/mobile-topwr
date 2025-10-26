import "package:flutter/material.dart";
import "package:flutter_svg/svg.dart";

import "../../../gen/assets.gen.dart";
import "../../../theme/app_theme.dart";
import "../../../utils/context_extensions.dart";
import "../../../widgets/detail_views/pop_button.dart";

class RadioLuzAppBar extends AppBar {
  RadioLuzAppBar(BuildContext context, {super.key, double? logoSize, double toolbarHeight = 60, super.actions})
    : super(
        primary: true,
        title: AppBarLuz(logoSize: logoSize),
        centerTitle: false,
        titleSpacing: 0,
        backgroundColor: context.colorTheme.whiteSoap,
        scrolledUnderElevation: 0,
        automaticallyImplyLeading: false,
        toolbarHeight: toolbarHeight,
        leading: const Align(
          alignment: Alignment.centerLeft,
          child: Padding(padding: EdgeInsets.only(left: 4), child: DetailViewPopButton()),
        ),
        actionsPadding: EdgeInsets.zero,
      );
}

class AppBarLuz extends StatelessWidget {
  const AppBarLuz({super.key, this.logoSize});

  final double? logoSize;
  static Future<void> precacheImageIfAbsent() async {
    final loader = SvgAssetLoader(Assets.svg.radioLuz.radioLuzLogo);
    await svg.cache.putIfAbsent(loader.cacheKey(null), () => loader.loadBytes(null));
  }

  @override
  Widget build(BuildContext context) {
    final scaler = context.textScaler.clamp(maxScaleFactor: 1.5);
    final size = logoSize == null ? null : scaler.scale(logoSize!);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Align(
        alignment: Alignment.centerRight,
        child: SvgPicture.asset(Assets.svg.radioLuz.radioLuzLogo, width: size, height: size),
      ),
    );
  }
}
