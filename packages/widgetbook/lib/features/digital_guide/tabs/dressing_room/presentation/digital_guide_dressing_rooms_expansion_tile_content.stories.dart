import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/widgets.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:topwr/features/digital_guide/data/models/digital_guide_response.dart";
import "package:topwr/features/digital_guide/tabs/dressing_room/data/models/digital_guide_dressing_room.dart";
import "package:topwr/features/digital_guide/tabs/dressing_room/data/repository/dressing_rooms_repository.dart";
import "package:topwr/features/digital_guide/tabs/dressing_room/presentation/digital_guide_dressing_rooms_expansion_tile.dart";
import "package:widgetbook/widgetbook.dart";

part "digital_guide_dressing_rooms_expansion_tile_content.stories.g.dart";

const mockDigitalGuideResponse = DigitalGuideResponse(
  id: 1,
  externalId: 123,
  translations: DigitalGuideTranslations(
    plTranslation: DigitalGuideTranslation(
      name: "C-13 Serowiec",
      extendedName: "Budynek C-13 Politechniki Wrocławskiej",
      address: "Wyb. Wyspiańskiego 23-25, 50-370 Wrocław",
      evacuationDescription: "Kieruj się oznaczeniami ewakuacyjnymi do najbliższej klatki schodowej.",
    ),
  ),
  numberOfStoreys: 3,
  canAssistanceDog: false,
  isInductionLoop: false,
  isMicroNavigationSystem: false,
  areGuidancePaths: false,
  areBrailleBoards: false,
  areLargeFontBoards: false,
  isSignLanguageInterpreter: false,
  areEmergencyChairs: false,
  phoneNumbers: ["111222333"],
  surroundingId: 42,
  images: [],
  evacuationMapId: 1,
  locationMapId: 2,
  levelsIndices: [],
  accessId: 1,
  accessibilityLevelForMotorDisability: 0,
  accessibilityLevelForBlind: 0,
  accessibilityLevelForVisuallyImpaired: 0,
  accessibilityLevelForHardOfHearing: 0,
  accessibilityLevelForHighSensorySensitivity: 0,
  accessibilityLevelForCognitiveDifficulties: 0,
);

const _mockDressingRoom = DigitalGuideDressingRoom(
  id: 1,
  isMarked: "yes",
  isVisibleFromAfar: "yes",
  areAccessBarriers: "no",
  areSeatsAvailable: "yes",
  isMovementSpace: "yes",
  isGoodLit: "yes",
  counterHeight: 90,
  isSpaceUnderCounter: "yes",
  isSpaceOnCounter: "yes",
  translations: DigitalGuideTranslationsDressingRoom(
    pl: DigitalGuideTranslationDressingRoom(
      location: "Parter, obok wejścia od strony dziedzińca.",
      workingDaysAndHours: "Poniedziałek-piątek, 8:00-18:00",
      comment: "Szatnia znajduje się przy głównym korytarzu i jest oznaczona tablicą kierunkową.",
      isMarkedComment: "Szatnia jest oznaczona tablicą kierunkową.",
      isVisibleFromAfarComment: "Wejście do szatni jest widoczne z głównego korytarza.",
      areAccessBarriersComment: "Na dojściu do szatni nie ma barier architektonicznych.",
      areSeatsAvailableComment: "Przy szatni dostępne są miejsca siedzące.",
      isMovementSpaceComment: "Przed ladą jest przestrzeń manewrowa dla wózka.",
      isGoodLitComment: "Strefa szatni jest równomiernie oświetlona.",
      isSpaceUnderCounterComment: "Pod ladą pozostawiono wolną przestrzeń.",
      isSpaceOnCounterComment: "Na ladzie jest miejsce do odłożenia rzeczy.",
    ),
  ),
  imagesIds: [6, 7],
);

const meta = Meta<DigitalGuideDressingRoomsExpansionTileContent>();

final $defaultMock = DigitalGuideDressingRoomsExpansionTileContentStory(
  setup: (context, child, args) => ProviderScope(
    key: ValueKey("dressing-room-${args.digitalGuideResponse.id}"),
    overrides: [
      dressingRoomsRepositoryProvider.overrideWith((ref, response) async => IListConst(const [_mockDressingRoom])),
    ],
    child: child,
  ),
  args: DigitalGuideDressingRoomsExpansionTileContentArgs(digitalGuideResponse: Arg.fixed(mockDigitalGuideResponse)),
);
