import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/widgets.dart";

import "../../data/business/formatting_utils.dart";
import "../models/digital_guide_entrace.dart";

extension DigitalGuideEntraceOperations on BuildContext {
  IList<String> getEntranceCommentsList(
    DigitalGuideEntrace entrance,
  ) {
    final comments = entrance.translations.pl;

    final IList<String> commentsList = [
      "${formatBool(key: "isBuildingMarkedFromEntrance", value: entrance.isBuildingMarkedFromEntrance)}. ${comments.isBuildingMarkedFromEntranceComment}",
      "${formatBool(key: "isSolidSurface", value: entrance.isSolidSurface)}. ${comments.isSolidSurfaceComment}",
      "${formatBool(key: "hasSoundTransmitter", value: entrance.hasSoundTransmitter,)}. ${comments.hasSoundTransmitterComment}",
      "${formatBool(key: "hasTactilePaving", value: entrance.hasTactilePaving)}. ${comments.hasTactilePavingComment}",
      comments.entranceThreats,
    ].where((c) => c.isNotEmpty).toIList();

    return commentsList;
  }
}
