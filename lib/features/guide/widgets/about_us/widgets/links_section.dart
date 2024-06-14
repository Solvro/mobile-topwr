import 'package:flutter/material.dart';

import '../../../../../config/ui_config.dart';
import '../../../../../theme/app_theme.dart';
import '../../../../../utils/launch_url_util.dart';
import '../../../../../widgets/my_icon.dart';
import '../models/link_data.dart';

class LinksSection extends StatelessWidget {
  const LinksSection({super.key, required this.links});

  final List<LinkData> links;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(horizontal: AboutUsConfig.defaultPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          for (final item in links)
            _IconWithUrl(url: item.url ?? '', iconPath: item.iconUrl)
        ],
      ),
    );
  }
}

class _IconWithUrl extends StatelessWidget {
  const _IconWithUrl({required this.url, required this.iconPath});

  final String url;
  final String iconPath;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        LaunchUrlUtil.launch(url);
      },
      child: Container(
        decoration: BoxDecoration(
          color: context.colorTheme.greyLight,
          borderRadius: BorderRadius.circular(AboutUsConfig.borderRadius),
        ),
        child: Padding(
          padding: const EdgeInsets.all(
            AboutUsConfig.iconPadding,
          ),
          child: Image.asset(iconPath),
        ),
      ),
    );
  }
}
