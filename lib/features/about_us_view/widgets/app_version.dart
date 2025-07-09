import "package:flutter/material.dart";
import "package:package_info_plus/package_info_plus.dart";

import "../../../config/ui_config.dart";
import "../../../theme/app_theme.dart";
import "../../../utils/context_extensions.dart";
import "../../splash_screen/widgets/flutter_splash_screen.dart";
import "../utils/custom_license_dialog.dart";

class AppVersionTile extends StatelessWidget {
  const AppVersionTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: WideTileCardConfig.basePadding),
      child: FutureBuilder(
        future: Future.microtask(PackageInfo.fromPlatform),
        builder: (context, snapshot) => Semantics(
          label:
              "${context.localize.version} ${snapshot.data?.version.replaceAll(".", " ")} ${context.localize.app_info}",
          child: ListTile(
            title: ExcludeSemantics(
              child: Text(
                "${MyAppConfig.title} ${snapshot.data?.version} ${context.localize.app_info}",
                style: context.textTheme.bodyGrey,
              ),
            ),
            leading: ExcludeSemantics(child: Icon(Icons.info, color: context.colorTheme.orangePomegranade, size: 22)),
            contentPadding: const EdgeInsets.symmetric(horizontal: WideTileCardConfig.basePadding),
            horizontalTitleGap: 8,
            onTap: () async {
              // TODO(simon-the-shark): customize [LicensePage] theme
              await showMyLicenceDialog(context, snapshot.data?.version);
            },
          ),
        ),
      ),
    );
  }
}

Future<void> showMyLicenceDialog(BuildContext context, String? applicationVersion) {
  return showCustomLicenseDialog(
    context: context,
    applicationIcon: Container(
      width: 50,
      height: 50,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
      child: const FlutterSplashScreen(),
    ),
    applicationName: MyAppConfig.title,
    applicationVersion: applicationVersion ?? context.localize.no_version,
    applicationLegalese: MyAppConfig.legalese,
  );
}
