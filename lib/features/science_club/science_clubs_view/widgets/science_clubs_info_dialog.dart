import "dart:async";

import "package:flutter/gestures.dart" show TapGestureRecognizer;
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "../../../../config/ui_config.dart";
import "../../../../theme/app_theme.dart";
import "../../../../utils/context_extensions.dart";
import "../../../../utils/launch_url_util.dart";
import "../../../../widgets/my_text_button.dart";

class ScienceClubInfoDialog extends StatelessWidget {
  const ScienceClubInfoDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(ScienceClubsViewConfig.rectangleBorderRadius)),
      child: Padding(
        padding: const EdgeInsets.all(
          ScienceClubsViewConfig.mediumPadding,
        ).copyWith(bottom: ScienceClubsViewConfig.smallPadding),
        child: Column(
          spacing: ScienceClubsViewConfig.listSeparatorSize,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              context.localize.add_club_contact_info_question,
              textAlign: TextAlign.center,
              style: context.textTheme.headline,
            ),

            Consumer(
              builder:
                  (context, ref, child) => RichText(
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
            MyTextButton(onClick: () => Navigator.of(context).pop(), actionTitle: context.localize.ok),
          ],
        ),
      ),
    );
  }
}
