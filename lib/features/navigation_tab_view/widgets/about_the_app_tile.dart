import "dart:async";

import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:package_info_plus/package_info_plus.dart";

import "../../../utils/context_extensions.dart";
import "../../about_us_view/widgets/app_version.dart";
import "../../analytics/data/clarity.dart";
import "../../analytics/data/clarity_events.dart";
import "navigation_tile.dart";

class AboutTheAppTile extends ConsumerWidget {
  const AboutTheAppTile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder(
      future: Future.microtask(PackageInfo.fromPlatform),
      builder: (context, snapshot) => NavigationTile(
        onTap: () async {
          unawaited(ref.trackEvent(ClarityEvents.openAboutTheApp));
          await showMyLicenceDialog(context, snapshot.data?.version);
        },
        title: context.localize.about_the_app,
        icon: Icons.info,
      ),
    );
  }
}
