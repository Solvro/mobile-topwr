import "dart:core";

import "package:fast_immutable_collections/fast_immutable_collections.dart";

import "../../tabs/entraces/data/models/digital_guide_entrace.dart";
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
    required this.evacuationMapId,
    required this.evacuationMapUrl,
    required this.entraces,
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
  final int evacuationMapId;
  final String? evacuationMapUrl;
  final IList<DigitalGuideEntrace> entraces;

  factory DigitalGuideResponseExtended.fromDigitalGuideResponse({
    required DigitalGuideResponse digitalGuideResponse,
    required String? imageUrl,
    required String? evacuationMapUrl,
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
      evacuationMapId: digitalGuideResponse.evacuationMapId,
      evacuationMapUrl: evacuationMapUrl,
      entraces: entraces,
    );
  }
}
