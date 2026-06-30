import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:topwr/features/digital_guide/data/repository/digital_guide_repository.dart";
import "package:topwr/features/digital_guide/presentation/digital_guide_view.dart";
import "package:widgetbook/widgetbook.dart";

import "../../../widgetbook_mocks.dart";

part "digital_guide_view.stories.g.dart";

const meta = Meta(DigitalGuideView.new);

final $default = DigitalGuideViewStory(
  name: "Production view with hardcoded data",
  setup: (context, child, args) => ProviderScope(
    overrides: [
      digitalGuideRepositoryProvider(
        args.ourId,
      ).overrideWith((ref) => (building: mockBuilding, digitalGuideData: mockDigitalGuideResponse, photoUrl: null)),
    ],
    child: child,
  ),
  args: DigitalGuideViewArgs.fixed(ourId: "1"),
);
