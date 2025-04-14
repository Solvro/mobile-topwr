import "package:flutter/material.dart";
import "../../../../config/ui_config.dart";
import "../../../../l10n/app_localizations.dart";

class ScienceClubInfoDialog extends StatelessWidget {
  const ScienceClubInfoDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(ScienceClubsViewConfig.rectangleBorderRadius)),
      child: Padding(
        padding: const EdgeInsets.all(ScienceClubsViewConfig.smallPadding),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              AppLocalizations.of(context)!.add_club_contact_info_question,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: ScienceClubsViewConfig.listSeparatorSize),
            Text(AppLocalizations.of(context)!.add_club_contact_info, textAlign: TextAlign.center),
            const SizedBox(height: ScienceClubsViewConfig.listSeparatorSize),
            TextButton(onPressed: () => Navigator.of(context).pop(), child: Text(AppLocalizations.of(context)!.ok)),
          ],
        ),
      ),
    );
  }
}
