import "dart:async";

import "package:flutter/gestures.dart" show TapGestureRecognizer;
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "../../../../config/ui_config.dart";
import "../../../../theme/app_theme.dart";
import "../../../../utils/context_extensions.dart";
import "../../../../utils/launch_url_util.dart";

class ScienceClubInfoDialog extends StatelessWidget {
  const ScienceClubInfoDialog({super.key});

  @override
  Widget build(BuildContext context) {
    const horizontalPadding = 36.0;
    const bottomPadding = 24.0;
    return AlertDialog(
      titlePadding: const EdgeInsets.only(left: horizontalPadding, top: 32, right: horizontalPadding),
      contentPadding: const EdgeInsets.only(
        left: horizontalPadding,
        top: 16,
        right: horizontalPadding,
        bottom: bottomPadding / 1.5,
      ),
      actionsPadding: const EdgeInsets.only(
        bottom: bottomPadding,
        left: horizontalPadding / 1.5,
        right: horizontalPadding / 1.5,
      ),
      actionsAlignment: MainAxisAlignment.center,
      title: Text(context.localize.add_club_contact_info_question, style: context.textTheme.headline),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          style: TextButton.styleFrom(padding: const EdgeInsets.all(12)),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  context.localize.ok,
                  textAlign: TextAlign.center,
                  style: context.textTheme.boldBodyOrange.copyWith(color: context.colorTheme.orangePomegranade),
                ),
              ),
            ],
          ),
        ),
      ],
      content: Column(
        spacing: ScienceClubsViewConfig.listSeparatorSize,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Consumer(
            builder:
                (context, ref, child) => RichText(
                  textScaler: context.textScaler,
                  text: TextSpan(
                    text: context.localize.add_club_contact_info,
                    style: context.textTheme.lightTitle,
                    children: [
                      TextSpan(
                        text: context.localize.report_change_email,
                        style: context.textTheme.lightTitleOrange.copyWith(decoration: TextDecoration.underline),
                        recognizer:
                            TapGestureRecognizer()
                              ..onTap = () async {
                                final emailUrl = "mailto:${context.localize.report_change_email}";
                                unawaited(ref.launch(emailUrl));
                              },
                      ),
                      const TextSpan(text: "."),
                    ],
                  ),
                ),
          ),
        ],
      ),
    );
  }
}
