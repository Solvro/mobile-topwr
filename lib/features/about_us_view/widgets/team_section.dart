import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:flutter_svg/svg.dart";

import "../../../config/ui_config.dart";
import "../../../theme/app_theme.dart";
import "../../../utils/determine_contact_icon.dart";
import "../../../utils/launch_url_util.dart";

import "../../../widgets/my_cached_image.dart";
import "../models/member_data.dart";

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
          for (final member in members) _TeamMemberCard(member: member),
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
      padding: const EdgeInsets.only(bottom: 8),
      child: Container(
        width: double.infinity,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: context.colorTheme.greyLight,
          borderRadius: BorderRadius.circular(AboutUsConfig.borderRadius),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox.square(
              dimension: AboutUsConfig.photoSize,
              child: MyCachedImage(member.imageUrl),
            ),
            const SizedBox(
              width: 14,
            ),
            _Description(
              name: member.name ?? "",
              subtitle: member.subtitle ?? "",
              links: member.links,
            ),
          ],
        ),
      ),
    );
  }
}

class _Icon extends ConsumerWidget {
  const _Icon({required this.icon, required this.launchUrl});
  final String launchUrl;
  final String icon;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(right: 11),
      child: GestureDetector(
        onTap: () async {
          await ref.launch(launchUrl);
        },
        child: SizedBox.square(dimension: 22, child: SvgPicture.asset(icon)),
      ),
    );
  }
}

class _Description extends StatelessWidget {
  const _Description({
    required this.name,
    required this.subtitle,
    required this.links,
  });
  final String name;
  final String subtitle;
  final List<ContactIconsModel> links;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 9, bottom: 4),
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
          children: [
            for (final icon in links)
              _Icon(
                launchUrl: icon.url ?? "",
                icon: icon.icon,
              ),
          ],
        ),
      ],
    );
  }
}
