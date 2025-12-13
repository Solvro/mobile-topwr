import "package:flutter/material.dart";
import "package:flutter_svg/flutter_svg.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";

import "../../../gen/assets.gen.dart";
import "../../../theme/app_theme.dart";
import "../../../utils/launch_url_util.dart";

typedef SocialIconData = ({String assetPath, String url});

final List<SocialIconData> _socialIconsData = [
  (assetPath: Assets.svg.contactIcons.fb, url: "https://www.facebook.com/radioluz"),
  (assetPath: Assets.svg.contactIcons.yt, url: "https://www.youtube.com/@AkademickieRadioLUZ"),
  (assetPath: Assets.svg.logoAppBar, url: "https://topwr.solvro.pl/sci-clubs/1365"),
  (assetPath: Assets.svg.contactIcons.ig, url: "https://www.instagram.com/radio_luz/"),
  (assetPath: Assets.svg.contactIcons.web, url: "https://radioluz.pl/"),
];

class RadioLuzSocialsSection extends ConsumerWidget {
  const RadioLuzSocialsSection({super.key, this.iconSize = 20});

  final double iconSize;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        _socialIconsData.length,
        (index) => Padding(
          padding: EdgeInsets.only(right: index == _socialIconsData.length - 1 ? 0 : 16),
          child: InkWell(
            onTap: () => ref.launch(_socialIconsData[index].url),
            child: SvgPicture.asset(
              _socialIconsData[index].assetPath,
              width: iconSize,
              height: iconSize,
              colorFilter: ColorFilter.mode(context.colorTheme.blackMirage, BlendMode.srcIn),
            ),
          ),
        ),
      ),
    );
  }
}
