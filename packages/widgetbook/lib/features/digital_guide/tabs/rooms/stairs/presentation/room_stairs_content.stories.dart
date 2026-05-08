import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:topwr/features/digital_guide/tabs/rooms/stairs/models/room_stairs_response.dart";
import "package:topwr/features/digital_guide/tabs/rooms/stairs/presentation/room_stairs_content.dart";
import "package:topwr/features/digital_guide/tabs/rooms/stairs/repository/room_stairs_repository.dart";
import "package:widgetbook/widgetbook.dart";

part "room_stairs_content.stories.g.dart";

const meta = Meta<RoomStairsContent>();

const _mockRoomStairs = RoomStairsResponse(
  id: 1,
  translations: RoomStairsTranslations(
    pl: RoomStairsTranslation(
      location: "Between ground floor and first floor",
      isGoodLitComment: "Landing is well lit.",
      isNonslipSurfaceComment: "Anti-slip strips are present.",
      isStairsSurfaceShinyComment: "No excessive shine.",
      isGoodStairsWallContrastComment: "Wall and step contrast is clear.",
      areStepsEdgesMarkedInContrastedWayComment: "Step edges are marked.",
      areAllStepsHaveSameDimensionsComment: "Step dimensions are uniform.",
      isRailingComment: "Railing available on side.",
      isGoodRailingContrastComment: "Railing is high contrast.",
      isRoundCrossSectionRailingComment: "Round section railing.",
      isRamp: "No",
      isRailingOnRampComment: "Not applicable.",
      isEdgeBetweenRampRowEntranceMarkedComment: "Not applicable.",
      comment: "Room stairs are accessible.",
    ),
  ),
  stairsWidth: 130,
  isGoodLit: "yes",
  isNonslipSurface: "yes",
  isStairsSurfaceShiny: "no",
  isGoodStairsWallContrast: "yes",
  areStepsEdgesMarkedInContrastedWay: "yes",
  areAllStepsHaveSameDimensions: "yes",
  isRailing: "yes",
  railingHeight: 95,
  isGoodRailingContrast: "yes",
  isRoundCrossSectionRailing: "yes",
  isRailingOnRamp: "no",
  isEdgeBetweenRampRowEntranceMarked: "no",
);

final $default = RoomStairsContentStory(
  setup: (context, child, args) => ProviderScope(
    overrides: [
      roomStairsRepositoryProvider(args.roomStairsId).overrideWith((ref) async => _mockRoomStairs),
    ],
    child: child,
  ),
  args: RoomStairsContentArgs.fixed(roomStairsId: 1),
);
