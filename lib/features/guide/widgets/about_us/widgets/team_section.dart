import 'package:flutter/material.dart';

import '../../../../../api_base/directus_assets_url.dart';
import '../../../../../config/ui_config.dart';
import '../../../../../theme/app_theme.dart';
import '../../../../../utils/launch_url_util.dart';
import '../../../../../utils/url_icons.dart';
import '../../../../../widgets/my_cached_image.dart';
import '../models/member_data.dart';

class TeamSection extends StatelessWidget {
  const TeamSection({super.key, required this.members});
  final List<MemberData> members;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(horizontal: AboutUsConfig.defaultPadding),
      child: Column(
        children: [
          for (final member in members) _TeamMemberCard(member: member)
        ],
      ),
    );
  }
}

class _TeamMemberCard extends StatelessWidget {
  const _TeamMemberCard({required this.member});
  final MemberData member;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: context.colorTheme.greyLight,
          borderRadius: BorderRadius.circular(AboutUsConfig.borderRadius),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox.square(
              dimension: AboutUsConfig.photoSize,
              child: MyCachedImage(member.imageUrl.directusUrl),
            ),
            const SizedBox(
              width: 14,
            ),
            _Description(
              name: member.name ?? '',
              subtitle: member.subtitle ?? '',
              links: member.links,
            )
          ],
        ),
      ),
    );
  }
}

class _Icon extends StatelessWidget {
  const _Icon({required this.iconPath, required this.iconUrl});
  final String iconUrl;
  final String iconPath;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 11.0),
      child: GestureDetector(
        onTap: () async {
          await LaunchUrlUtil.launch(iconUrl);
        },
        child: Image.asset(iconPath),
      ),
    );
  }
}

class _Description extends StatelessWidget {
  const _Description(
      {required this.name, required this.subtitle, required this.links});
  final String name;
  final String subtitle;
  final List<UrlIconsUtilModel> links;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 9.0, bottom: 4.0),
          child: Text(
            name,
            style: context.aboutUsTheme.headlineSmaller,
          ),
        ),
        Text(subtitle, style: context.aboutUsTheme.bodySmaller),
        const SizedBox(
          height: 6,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            for (final icon in links)
              _Icon(
                iconUrl: icon.url ?? '',
                iconPath: icon.iconUrl,
              )
          ],
        )
      ],
    );
}
}
