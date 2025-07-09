import "dart:async";

import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../../config/ui_config.dart";
import "../../../../theme/app_theme.dart";
import "../../../../utils/context_extensions.dart";
import "../../tabs/accessibility_dialog/presentation/accessibility_dialog.dart";

class AccessibilityButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: Semantics(
        label: context.localize.accessibility_profiles,
        button: true,
        enabled: true,
        child: ExcludeSemantics(
          child: Consumer(
            builder: (context, ref, child) => OutlinedButton(
              onPressed: () {
                unawaited(AccessibilityDialog.show(context, ref));
              },

              style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(DigitalGuideConfig.borderRadiusMedium),
                ),
                side: BorderSide(color: context.colorTheme.greyPigeon),
                backgroundColor: context.colorTheme.greyLight,
                padding: const EdgeInsets.symmetric(horizontal: 16),
              ),
              child: Icon(
                Icons.accessibility_new,
                color: context.colorTheme.blackMirage,
                size: context.textScaler.clamp(maxScaleFactor: 2.5).scale(16),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
