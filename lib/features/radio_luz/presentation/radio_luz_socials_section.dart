import "package:flutter/material.dart";
import "package:flutter_svg/flutter_svg.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";

import "../../../gen/assets.gen.dart";
import "../../../theme/app_theme.dart";
import "../../../utils/launch_url_util.dart";
import "../../branches/data/model/branch.dart";
import "../../navigator/utils/navigation_commands.dart";
import "../../science_club/science_clubs_filters/model/sci_club_type.dart";
import "../../science_club/science_clubs_view/model/science_clubs.dart";

typedef SocialIconData = ({String assetPath, String url, bool inApp, ScienceClub? circle});

final List<SocialIconData> _socialIconsData = [
  (assetPath: Assets.svg.contactIcons.fb, url: "https://www.facebook.com/radioluz", inApp: false, circle: null),
  (
    assetPath: Assets.svg.contactIcons.yt,
    url: "https://www.youtube.com/@AkademickieRadioLUZ",
    inApp: false,
    circle: null,
  ),
  (assetPath: Assets.svg.contactIcons.ig, url: "https://www.instagram.com/radio_luz/", inApp: false, circle: null),
  (assetPath: Assets.svg.contactIcons.web, url: "https://radioluz.pl/", inApp: false, circle: null),
  (
    assetPath: Assets.svg.logoAppBar,
    url: "",
    inApp: true,
    circle: const ScienceClub(
      id: 1365,
      name: "",
      organizationStatus: ScienceClubStatus.active,
      source: ScienceClubSource.manualEntry,
      organizationType: ScienceClubType.studentOrganization,
      coverPreview: false,
      isStrategic: false,
      branch: Branch.main,
    ),
  ),
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
            onTap: () => _socialIconsData[index].inApp
                ? ref.navigateSciClubsDetail(_socialIconsData[index].circle!)
                : ref.launch(_socialIconsData[index].url),
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
