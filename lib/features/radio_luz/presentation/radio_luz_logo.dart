import "package:flutter/widgets.dart";
import "package:flutter_svg/svg.dart";

import "../../../gen/assets.gen.dart";
import "../../../utils/context_extensions.dart";

class RadioLuzLogo extends StatelessWidget {
  const RadioLuzLogo({super.key, this.logoSize, this.logoColor});

  final Color? logoColor;

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
      child: SvgPicture.asset(
        Assets.svg.radioLuz.radioLuzLogo,
        width: size,
        height: size,
        colorFilter: logoColor != null ? ColorFilter.mode(logoColor!, BlendMode.srcIn) : null,
      ),
    );
  }
}
