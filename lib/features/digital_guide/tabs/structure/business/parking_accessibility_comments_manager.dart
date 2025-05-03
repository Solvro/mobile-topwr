import "package:fast_immutable_collections/fast_immutable_collections.dart";

import "../../../../../l10n/app_localizations.dart";
import "../../../business/accessibility_comments_manager.dart";
import "../data/models/parking.dart";

class ParkingsAccessibilityCommentsManager extends AccessibilityCommentsManager {
  ParkingsAccessibilityCommentsManager({required this.l10n, required this.parking});

  final AppLocalizations l10n;
  final DigitalGuideParking parking;

  @override
  IList<String> getCommentsListForBlind() {
    final comments = parking.translations.plTranslation;

    return IList([
      "${l10n.parking_are_spaces_for_pwd(parking.areSpacesForPwd.toLowerCase())} ${comments.areSpacesForPwdComment}",
      if (parking.shortestLengthToNearestSpacesForPwd > 0)
        l10n.parking_shortest_length_to_nearest_spaces_for_pwd(parking.shortestLengthToNearestSpacesForPwd),
    ]).toIList();
  }

  @override
  IList<String> getCommentsListForCognitiveImpairment() {
    final comments = parking.translations.plTranslation;

    return IList([
      "${l10n.parking_are_spaces_for_pwd(parking.areSpacesForPwd.toLowerCase())} ${comments.areSpacesForPwdComment}",
      if (parking.shortestLengthToNearestSpacesForPwd > 0)
        l10n.parking_shortest_length_to_nearest_spaces_for_pwd(parking.shortestLengthToNearestSpacesForPwd),
    ]).toIList();
  }

  @override
  IList<String> getCommentsListForHearingImpairment() {
    final comments = parking.translations.plTranslation;

    return IList([
      "${l10n.parking_are_spaces_for_pwd(parking.areSpacesForPwd.toLowerCase())} ${comments.areSpacesForPwdComment}",
      "${l10n.parking_are_spaces_for_pwd_vertical_marked(parking.areSpacesForPwdVerticalMarked.toLowerCase())} ${comments.areSpacesForPwdVerticalMarkedComment}",
      if (parking.shortestLengthToNearestSpacesForPwd > 0)
        l10n.parking_shortest_length_to_nearest_spaces_for_pwd(parking.shortestLengthToNearestSpacesForPwd),
    ]).toIList();
  }

  @override
  IList<String> getCommentsListForLowVision() {
    final comments = parking.translations.plTranslation;

    return IList([
      "${l10n.parking_are_spaces_for_pwd(parking.areSpacesForPwd.toLowerCase())} ${comments.areSpacesForPwdComment}",
      "${l10n.parking_are_spaces_for_pwd_vertical_marked(parking.areSpacesForPwdVerticalMarked.toLowerCase())} ${comments.areSpacesForPwdVerticalMarkedComment}",
      if (parking.shortestLengthToNearestSpacesForPwd > 0)
        l10n.parking_shortest_length_to_nearest_spaces_for_pwd(parking.shortestLengthToNearestSpacesForPwd),
    ]).toIList();
  }

  @override
  IList<String> getCommentsListForMotorImpairment() {
    final comments = parking.translations.plTranslation;

    return IList([
      "${l10n.parking_are_spaces_for_pwd(parking.areSpacesForPwd.toLowerCase())} ${comments.areSpacesForPwdComment}",
      "${l10n.parking_are_spaces_for_pwd_vertical_marked(parking.areSpacesForPwdVerticalMarked.toLowerCase())} ${comments.areSpacesForPwdVerticalMarkedComment}",
      "${l10n.parking_is_road_accessible_for_people_in_wheelchairs(parking.isRoadAccessibleForPeopleInWheelchairs.toLowerCase())} ${comments.isRoadAccessibleForPeopleInWheelchairsComment}",
      if (parking.shortestLengthToNearestSpacesForPwd > 0)
        l10n.parking_shortest_length_to_nearest_spaces_for_pwd(parking.shortestLengthToNearestSpacesForPwd),
    ]).toIList();
  }

  @override
  IList<String> getCommentsListForSensorySensitivity() {
    final comments = parking.translations.plTranslation;

    return IList([
      "${l10n.parking_are_spaces_for_pwd(parking.areSpacesForPwd.toLowerCase())} ${comments.areSpacesForPwdComment}",
      if (parking.shortestLengthToNearestSpacesForPwd > 0)
        l10n.parking_shortest_length_to_nearest_spaces_for_pwd(parking.shortestLengthToNearestSpacesForPwd),
    ]).toIList();
  }
}
