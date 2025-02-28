import "package:flutter/material.dart";
import "package:package_info_plus/package_info_plus.dart";

import "../../../utils/context_extensions.dart";
import "../../about_us_view/widgets/app_version.dart";
import "navigation_tile.dart";

class AboutTheAppTile extends StatelessWidget {
  const AboutTheAppTile({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.microtask(PackageInfo.fromPlatform),
      builder:
          (context, snapshot) => NavigationTile(
            onTap: () async => showMyLicenceDialog(context, snapshot.data?.version),
            title: context.localize.about_the_app,
            icon: Icons.info,
          ),
    );
  }
}
