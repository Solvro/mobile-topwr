import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/widgets.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:topwr/features/digital_guide/tabs/structure/data/models/stairs.dart";
import "package:topwr/features/digital_guide/tabs/structure/data/repository/stairs_repository.dart";
import "package:topwr/features/digital_guide/tabs/structure/presentation/views/stairs_view.dart";
import "package:widgetbook/widgetbook.dart";

part "stairs_view.stories.g.dart";

const meta = Meta<StairsView>();

const _mockStairs = Stairs(
  id: 1,
  translations: StairsTranslations(
    plTranslation: StairsTranslation(
      location: "Main staircase near entrance",
      floorList: "0-1",
      isStairsSignInfoComment: "Direction signs are available.",
      isStairsSignInfoInEnComment: "English signs are available.",
      stairsWidth: "150 cm",
      numberOfStairGears: "1",
      numberOfStairLandings: "1",
      isSameNumberOfStairsComment: "All runs have uniform steps.",
      isGoodLitComment: "Stairs are well lit.",
      isStairsSurfaceShinyComment: "Surface is matte.",
      isNonslipSurfaceComment: "Anti-slip finish is present.",
      isGoodStairsWallContrastComment: "Clear visual contrast.",
      areEmergencyStairsComment: "Marked as emergency route.",
      areFirstAndLastStepsMarkedComment: "First and last steps marked.",
      areGradesNosePadsComment: "Nose pads are present.",
      areStepsRaisedMarkingsComment: "Raised markings are present.",
      isProperlyMarkedFreeSpaceUnderStairsComment: "Free space is marked.",
      comment: "Accessible staircase.",
    ),
  ),
  isStairsSignInfo: "yes",
  isStairsSignInfoInEn: "yes",
  isGoodLit: "yes",
  isStairsSurfaceShiny: "no",
  isNonslipSurface: "yes",
  isGoodStairsWallContrast: "yes",
  areEmergencyStairs: "yes",
  areFirstAndLastStepsMarked: "yes",
  areGradesNosePads: "yes",
  areStepsRaisedMarkings: "yes",
  stairsStepHeight: 16,
  isProperlyMarkedFreeSpaceUnderStairs: "yes",
  railingsIDs: IListConst([1]),
);

final $default = StairsViewStory(
  setup: (context, child, args) => ProviderScope(
    key: ValueKey("stairs-view-${args.stairsId}"),
    overrides: [stairsRepositoryProvider.overrideWith((ref, stairsID) async => _mockStairs)],
    child: child,
  ),
  args: StairsViewArgs.fixed(stairsId: 1),
);
