import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:topwr/config.dart';

import '../../../theme/app_theme.dart';

class LogoAppBar extends AppBar {
  /// AppBar with ToPwr colorful logo
  LogoAppBar(
    BuildContext context, {
    super.key,
  }) : super(
          title: const _AppBarLogo(),
          centerTitle: false,
          titleSpacing: 0,
          backgroundColor: context.colorTheme.whiteSoap,
          scrolledUnderElevation: 0,
        );
}

class _AppBarLogo extends StatelessWidget {
  /// ToPwr Appbar svg colorful themed logo
  const _AppBarLogo();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
      child: SvgPicture.asset(AppBarConfig.logoAssetName),
    );
  }
}
