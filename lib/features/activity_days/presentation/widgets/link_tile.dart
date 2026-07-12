import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:flutter_svg/flutter_svg.dart";

import "../../../../config/ui_config.dart";
import "../../../../utils/context_extensions.dart";
import "../../../../utils/determine_contact_icon.dart";
import "../../../../utils/launch_url_util.dart";
import "../../../../widgets/wide_tile_card.dart";
import "../../data/models/activity_days_response.dart";

class LinkTile extends ConsumerWidget {
  const LinkTile({required this.link, super.key});

  final ActivityDaysLink link;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final title = link.title ?? _hostFromUrl(link.url);
    final subtitle = link.subtitle ?? link.url;
    final iconPath = link.url.determineIcon();

    return Semantics(
      label: "$title, $subtitle",
      button: true,
      child: WideTileCard(
        title: title,
        subtitle: subtitle,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        onTap: () => ref.launch(link.url),
        trailing: SizedBox(
          height: context.textScaler.clamp(maxScaleFactor: 2).scale(WideTileCardConfig.imageSize),
          width: WideTileCardConfig.imageSize,
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: SvgPicture.asset(iconPath, semanticsLabel: title),
          ),
        ),
      ),
    );
  }

  String _hostFromUrl(String url) {
    try {
      return Uri.parse(url).host.replaceFirst(RegExp(r"^www\."), "");
    } on FormatException {
      return url;
    }
  }
}
