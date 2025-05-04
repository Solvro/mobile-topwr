import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:flutter_svg/svg.dart";

import "../../../config/ui_config.dart";
import "../../../theme/app_theme.dart";
import "../../../utils/context_extensions.dart";
import "../../../utils/determine_contact_icon.dart";
import "../../../utils/launch_url_util.dart";

class ContactSection extends StatelessWidget {
  const ContactSection({super.key, required this.links});

  final IList<ContactIconsModel> links;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AboutUsConfig.defaultPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [for (final item in links) _ContactIcon(url: item.url ?? "", icon: item.icon)],
      ),
    );
  }
}

class _ContactIcon extends ConsumerWidget {
  const _ContactIcon({required this.url, required this.icon});

  final String url;
  final String icon;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Semantics(
      label: "${context.localize.button_leading_to}: ${Uri.parse(url).host}",
      child: GestureDetector(
        onTap: () async => ref.launch(url),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: context.colorTheme.greyLight,
            borderRadius: BorderRadius.circular(AboutUsConfig.borderRadius),
          ),
          child: ExcludeSemantics(
            child: Padding(
              padding: const EdgeInsets.all(AboutUsConfig.iconPadding),
              child: Center(child: SvgPicture.asset(icon)),
            ),
          ),
        ),
      ),
    );
  }
}
