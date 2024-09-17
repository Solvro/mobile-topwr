import "package:flutter/material.dart";
import "package:package_info_plus/package_info_plus.dart";

import "../../../config/ui_config.dart";
import "../../../theme/app_theme.dart";
import "../../../utils/context_extensions.dart";
import "../../splash_screen/widgets/flutter_splash_screen.dart";

class AppVersionTile extends StatelessWidget {
  const AppVersionTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: WideTileCardConfig.basePadding,
      ),
      child: FutureBuilder(
        future: Future.microtask(PackageInfo.fromPlatform),
        builder: (context, snapshot) => ListTile(
          title: Text(
            "${MyAppConfig.title} ${snapshot.data?.version} ${context.localize.app_info}",
            style: context.textTheme.bodyGrey,
          ),
          leading: Icon(
            Icons.info,
            color: context.colorTheme.orangePomegranade,
            size: 22,
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: WideTileCardConfig.basePadding,
          ),
          horizontalTitleGap: 8,
          onTap: () {
            // TODO(simon-the-shark): customize [LicensePage] theme
            showAboutDialog(
              context: context,
              applicationIcon: const SizedBox.square(
                dimension: 20,
                child: FlutterSplashScreen(),
              ),
              applicationName: MyAppConfig.title,
              applicationVersion: snapshot.data?.version,
              applicationLegalese:
                  "\u{a9} 2024 Koło Naukowe Solvro, Politechnika Wrocławska",
            );
          },
        ),
      ),
    );
  }
}