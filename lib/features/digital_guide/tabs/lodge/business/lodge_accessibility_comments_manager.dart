// ignore_for_file: flutter_style_todos

import "package:fast_immutable_collections/fast_immutable_collections.dart";

import "../../../../../l10n/app_localizations.dart";
import "../../../business/accessibility_comments_manager.dart";
import "../data/models/digital_guide_lodge.dart";

class LodgeAccessibilityCommentsManager extends AccessibilityCommentsManager {
  LodgeAccessibilityCommentsManager({required this.l10n, required this.lodge});

  final AppLocalizations l10n;
  final DigitalGuideLodge lodge;

  @override
  IList<String> getCommentsListForBlind() {
    // TODO: implement getCommentsListForBlind
    throw UnimplementedError();
  }

  @override
  IList<String> getCommentsListForCognitiveImpairment() {
    // TODO: implement getCommentsListForCognitiveImpairment
    throw UnimplementedError();
  }

  @override
  IList<String> getCommentsListForHearingImpairment() {
    // TODO: implement getCommentsListForHearingImpairment
    throw UnimplementedError();
  }

  @override
  IList<String> getCommentsListForLowVision() {
    // TODO: implement getCommentsListForLowVision
    throw UnimplementedError();
  }

  @override
  IList<String> getCommentsListForMotorImpairment() {
    throw UnimplementedError();
    // final comments = lodge.translations.pl;

    // return IList([
    //   "${l10n.lodge_access_barriers(lodge.areAccessBarriers.toLowerCase())} ${comments.areAccessBarriersComment}",
    //   // "${l10n.lodge_movement_space(lodge.isMovementSpace.toLowerCase())} ${comments.isMovementSpaceComment}",
    //   // l10n.lodge_counter_height(lodge.counterHeight),
    //   // "${l10n.lodge_space_under_counter(lodge.isSpaceUnderCounter.toLowerCase())} ${comments.isSpaceUnderCounterComment}",
    // ]).map((element) => element.trim()).where((element) => element.isNotEmpty).toIList();
  }

  @override
  IList<String> getCommentsListForSensorySensitivity() {
    // TODO: implement getCommentsListForSensorySensitivity
    throw UnimplementedError();
  }
}
