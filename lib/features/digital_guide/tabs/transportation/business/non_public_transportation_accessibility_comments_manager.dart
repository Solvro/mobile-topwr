import "package:fast_immutable_collections/fast_immutable_collections.dart";

import "../../../../../l10n/app_localizations.dart";
import "../../../business/accessibility_comments_manager.dart";
import "../../accessibility_dialog/data/modes.dart";
import "../data/models/digital_guide_transportation.dart";

class NonPublicTransportationAccessibilityCommentsManager extends AccessibilityCommentsManager {
  NonPublicTransportationAccessibilityCommentsManager({required this.transportation, required this.l10n});

  final DigitalGuideTransportation transportation;
  final AppLocalizations l10n;

  //on website they show always those two no matter what profile is chosen
  IList<String> _alwaysAppearingComments() {
    final comments = transportation.translations.pl;

    final IList<String> commentsList = [
      comments.nearestDisabledParkingSpaces,
      l10n.transport_closest_parking_for_disabled(transportation.nearestDisabledParkingSpacesDistance.toString()),
    ].toIList();

    return commentsList;
  }

  @override
  IList<String> getCommentsListForBlind() {
    return _alwaysAppearingComments();
  }

  @override
  IList<String> getCommentsListForCognitiveImpairment() {
    return _alwaysAppearingComments();
  }

  @override
  IList<String> getCommentsListForHearingImpairment() {
    return _alwaysAppearingComments();
  }

  @override
  IList<String> getCommentsListForLowVision() {
    return _alwaysAppearingComments();
  }

  @override
  IList<String> getCommentsListForMotorImpairment() {
    return _alwaysAppearingComments();
  }

  @override
  IList<String> getCommentsListForSensorySensitivity() {
    return _alwaysAppearingComments();
  }

  //this method is implemented and usually there is no need to override it,
  //but since this profile always shows two same comments then there is
  //no need to look for repeated comments etc. just return those two
  @override
  IList<String> getCommentsForModes(ISet<ModeWithKey> modes) {
    return _alwaysAppearingComments();
  }
}
