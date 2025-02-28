import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/widgets.dart";
import "../../../../../../utils/context_extensions.dart";

import "../models/room_stairs_response.dart";

extension RoomStairsCommentListX on BuildContext {
  IList<String> getRoomStairsCommentsList(RoomStairsResponse roomStairsResponse) {
    final comments = roomStairsResponse.translations.pl;

    final IList<String> commentList =
        [
          roomStairsResponse.translations.pl.location,
          "${localize.room_stairs_is_nonslip_surface(roomStairsResponse.isNonslipSurface.toLowerCase())} ${comments.isNonslipSurfaceComment}",
        ].lock;

    return commentList;
  }

  IList<String> getRoomStairsAccessibilityCommentsList(RoomStairsResponse roomStairsResponse) {
    final comments = roomStairsResponse.translations.pl;

    final IList<String> commentList =
        [
          roomStairsResponse.translations.pl.location,
          "${localize.room_stairs_is_good_lit(roomStairsResponse.isGoodLit.toLowerCase())} ${comments.isGoodLitComment}",
          "${localize.room_stairs_is_stairs_surface_shiny(roomStairsResponse.isStairsSurfaceShiny.toLowerCase())} ${comments.isStairsSurfaceShinyComment}",
          "${localize.room_stairs_are_all_steps_have_same_dimensions(roomStairsResponse.areAllStepsHaveSameDimensions.toLowerCase())} ${comments.areAllStepsHaveSameDimensionsComment}",
          "${localize.room_stairs_is_railing(roomStairsResponse.isRailing.toLowerCase())} ${comments.isRailingComment}",
        ].where((c) => c.trim().isNotEmpty).toIList();

    return commentList;
  }
}
