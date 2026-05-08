import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:topwr/features/digital_guide/tabs/doors/data/model/door.dart";
import "package:topwr/features/digital_guide/tabs/doors/data/repository/doors_repository.dart";
import "package:topwr/features/digital_guide/tabs/doors/presentation/door_view.dart";
import "package:widgetbook/widgetbook.dart";

part "door_view.stories.g.dart";

const meta = Meta<DoorView>();

const _mockDoor = Door(
  translations: DoorTranslations(
    pl: DoorTranslation(
      comment: "Main entrance door.",
      fromTo: "Entrance hall -> corridor",
      isMainWingHighlightedComment: "Main wing has contrast strip.",
      isGoodDoorVisibleFromOutsideComment: "Visible from square.",
      isGoodDoorVisibleFromInsideComment: "Visible from inside hall.",
      isIncreasedForceRequiredComment: "No increased force needed.",
      isDoorCloserComment: "Soft door closer installed.",
      handleHeight: "95 cm",
      isElevatedThresholdComment: "No elevated threshold.",
    ),
  ),
  isMainWingHighlighted: "yes",
  isGoodDoorVisibleFromOutside: "yes",
  isGoodDoorVisibleFromInside: "yes",
  areOpenAutomatically: "no",
  isIncreasedForceRequired: "no",
  isDoorCloser: "yes",
  doorType: DoorType.singleLeafDoor,
  isGraphic: "yes",
  areVisible: "yes",
  areGlazed: "yes",
  areOpenOutwards: "no",
  isClosureFromInside: "yes",
  openingSystemType: "handle",
  isHandleHighlighted: "yes",
  isSameOpeningSystem: "yes",
  isKeyNeeded: "no",
  isElevatedThreshold: "no",
  doorWidth: 100,
);

final $default = DoorViewStory(
  setup: (context, child, args) => ProviderScope(
    overrides: [doorsRepositoryProvider(args.doorsID).overrideWith((ref) async => _mockDoor)],
    child: child,
  ),
  args: DoorViewArgs.fixed(doorsID: 1),
);
