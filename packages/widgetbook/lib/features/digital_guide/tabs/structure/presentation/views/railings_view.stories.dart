import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:topwr/features/digital_guide/tabs/structure/data/models/railing.dart";
import "package:topwr/features/digital_guide/tabs/structure/data/repository/railings_repository.dart";
import "package:topwr/features/digital_guide/tabs/structure/presentation/views/railings_view.dart";
import "package:widgetbook/widgetbook.dart";

part "railings_view.stories.g.dart";

const meta = Meta<RailingsView>();

const _mockRailing = Railing(
  translations: RailingTranslations(
    plTranslation: RailingTranslation(
      isRailingOnLandingsComment: "Railing is present on landings.",
      isTwoSidedRailingComment: "Two-sided support is available.",
      isBrailleConvexMarkingComment: "No braille marking.",
      isGoodRailingContrastComment: "Railing is high contrast.",
      isRoundCrossSectionRailingComment: "Round cross-section.",
      isRailingExtended30cmComment: "Railing extends beyond last step.",
      isRailingObstacleComment: "No obstacles near railing.",
      comment: "Railing is safe and easy to grip.",
    ),
  ),
  isRailingOnLandings: "yes",
  railingHeight: 95,
  isTwoSidedRailing: "yes",
  railingType: "round",
  isBrailleConvexMarking: "no",
  isGoodRailingContrast: "yes",
  isRoundCrossSectionRailing: "yes",
  isRailingExtended30cm: "yes",
  isRailingObstacle: "no",
);

final $default = RailingsViewStory(
  setup: (context, child, args) => ProviderScope(
    overrides: [railingsRepositoryProvider(args.railingId).overrideWith((ref) async => _mockRailing)],
    child: child,
  ),
  args: RailingsViewArgs.fixed(railingId: 1),
);
