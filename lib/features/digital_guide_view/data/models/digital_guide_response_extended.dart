import "dart:core";

import "package:fast_immutable_collections/fast_immutable_collections.dart";

import "../../tabs/entraces/data/models/digital_guide_entrace.dart";
import "../../tabs/evacuation/data/models/digital_guide_evacuation.dart";
import "digital_guide_response.dart";

class DigitalGuideResponseExtended {
  const DigitalGuideResponseExtended({
    required this.id,
    required this.translations,
    required this.numberOfStoreys,
    required this.canAssistanceDog,
    required this.isInductionLoop,
    required this.isMicroNavigationSystem,
    required this.areGuidancePaths,
    required this.areBrailleBoards,
    required this.areLargeFontBoards,
    required this.isSignLanguageInterpreter,
    required this.areEmergencyChairs,
    required this.phoneNumbers,
    required this.surroundingId,
    required this.images,
    required this.imageUrl,
    required this.levels,
    required this.entraces,
    required this.evacuation,
  });

  final int id;
  final DigitalGuideTranslations translations;
  final int numberOfStoreys;
  final bool canAssistanceDog;
  final bool isInductionLoop;
  final bool isMicroNavigationSystem;
  final bool areGuidancePaths;
  final bool areBrailleBoards;
  final bool areLargeFontBoards;
  final bool isSignLanguageInterpreter;
  final bool areEmergencyChairs;
  final List<String> phoneNumbers;
  final int surroundingId;
  final List<int> images;
  final String? imageUrl;
  final List<Level> levels;
  final DigitalGuideEvacuation evacuation;
  final IList<DigitalGuideEntrace> entraces;

  bool areAdaptedToilets() {

    for(final level in levels) {
      for(final region in level.regions) {
        if(region.adaptedToiletsIndices.isNotEmpty) {
          return true;
        }
      }
    }

    return false;

  }

  factory DigitalGuideResponseExtended.fromDigitalGuideResponse({
    required DigitalGuideResponse digitalGuideResponse,
    required String? imageUrl,
    required List<Level> levels,
    required DigitalGuideEvacuation evacuation,
    required IList<DigitalGuideEntrace> entraces,
  }) {
    return DigitalGuideResponseExtended(
      id: digitalGuideResponse.id,
      translations: digitalGuideResponse.translations,
      numberOfStoreys: digitalGuideResponse.numberOfStoreys,
      canAssistanceDog: digitalGuideResponse.canAssistanceDog,
      isInductionLoop: digitalGuideResponse.isInductionLoop,
      isMicroNavigationSystem: digitalGuideResponse.isMicroNavigationSystem,
      areGuidancePaths: digitalGuideResponse.areGuidancePaths,
      areBrailleBoards: digitalGuideResponse.areBrailleBoards,
      areLargeFontBoards: digitalGuideResponse.areLargeFontBoards,
      isSignLanguageInterpreter: digitalGuideResponse.isSignLanguageInterpreter,
      areEmergencyChairs: digitalGuideResponse.areEmergencyChairs,
      phoneNumbers: digitalGuideResponse.phoneNumbers,
      surroundingId: digitalGuideResponse.surroundingId,
      images: digitalGuideResponse.images,
      imageUrl: imageUrl,
      levels: levels,
      entraces: entraces,
      evacuation: evacuation,
    );
  }
}

class Level {
  const Level({
    required this.id,
    required this.floorNumber,
    required this.translations,
    required this.regions,
  });

  final int id;
  final int floorNumber;
  final LevelTranslations translations;
  final List<Region> regions;

  factory Level.create({
    required LevelNotFull levelNotFull,
    required List<Region> regions,
  }) {
    return Level(
      id: levelNotFull.id,
      floorNumber: levelNotFull.floorNumber,
      translations: levelNotFull.translations,
      regions: regions,
    );
  }
}
