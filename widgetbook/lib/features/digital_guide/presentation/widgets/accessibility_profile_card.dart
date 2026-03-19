import "package:flutter/widgets.dart";
import "package:topwr/features/digital_guide/presentation/widgets/accessibility_profile_card.dart";
import "package:topwr/features/digital_guide/tabs/structure/business/railings_accessibility_comments_manager.dart";
import "package:topwr/features/digital_guide/tabs/structure/data/models/railing.dart";
import "package:topwr/l10n/app_localizations_pl.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

@widgetbook.UseCase(name: "default", type: AccessibilityProfileCard)
Widget useCaseAccessibilityProfileCard(BuildContext context) {
  return AccessibilityProfileCard(
    accessibilityCommentsManager: RailingsAccessibilityCommentsManager(
      railing: const Railing(
        translations: RailingTranslations(
          plTranslation: RailingTranslation(
            isRailingOnLandingsComment: "Good landings",
            isTwoSidedRailingComment: "Two-sided",
            isBrailleConvexMarkingComment: "Braille present",
            isGoodRailingContrastComment: "Good contrast",
            isRoundCrossSectionRailingComment: "Round cross-section",
            isRailingExtended30cmComment: "Extended 30cm",
            isRailingObstacleComment: "No obstacles",
            comment: "General comment",
          ),
        ),
        isRailingOnLandings: "true",
        railingHeight: 1.2,
        isTwoSidedRailing: "true",
        railingType: "metal",
        isBrailleConvexMarking: "false",
        isGoodRailingContrast: "true",
        isRoundCrossSectionRailing: "false",
        isRailingExtended30cm: "false",
        isRailingObstacle: "false",
      ),
      l10n: AppLocalizationsPl(),
    ),
  );
}
