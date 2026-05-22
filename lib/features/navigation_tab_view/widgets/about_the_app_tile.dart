import "dart:async";

import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:package_info_plus/package_info_plus.dart";

import "../../../utils/context_extensions.dart";
import "../../about_us_view/widgets/app_version.dart";
import "../../analytics/data/clarity.dart";
import "../../analytics/data/clarity_events.dart";
import "../../feature_codes/presentation/feature_codes_dialog.dart";
import "navigation_tile.dart";

class AboutTheAppTile extends HookConsumerWidget {
  const AboutTheAppTile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final logoTapCount = useState(0);

    return FutureBuilder(
      future: Future.microtask(PackageInfo.fromPlatform),
      builder: (context, snapshot) => NavigationTile(
        onTap: () async {
          unawaited(ref.trackEvent(ClarityEvents.openAboutTheApp));
          await showMyLicenceDialog(
            context,
            snapshot.data?.version,
            onApplicationIconTap: (dialogContext) async {
              logoTapCount.value += 1;
              if (logoTapCount.value >= 5) {
                logoTapCount.value = 0;
                await FeatureCodesDialog.show(dialogContext);
              }
            },
          );
        },
        title: context.localize.about_the_app,
        icon: Icons.info,
      ),
    );
  }
}
