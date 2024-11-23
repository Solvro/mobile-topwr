import "package:flutter/material.dart";

import "../../../config/ui_config.dart";
import "../../../firebase_init.dart";
import "../../../theme/app_theme.dart";
import "../../../widgets/my_splash_tile.dart";

class NotificationButton extends StatelessWidget {
  const NotificationButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: SksConfig.outerPadding,
      child: MySplashTile(
        // TODO(simon-the-shark): show dialog about our future intented use of notifications
        onTap: requestFCMPermission,
        child: Container(
          padding: SksConfig.innerPadding,
          decoration: BoxDecoration(
            border: Border.all(
              color: context.colorTheme.orangePomegranade,
            ),
            borderRadius: BorderRadius.circular(SksConfig.radius),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: SksConfig.sizedBoxWidth,
            ),
            child: Icon(
              Icons.notifications,
              color: context.colorTheme.orangePomegranade,
            ),
          ),
        ),
      ),
    );
  }
}
