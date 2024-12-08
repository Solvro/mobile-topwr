import "dart:core";

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
    required this.telephoneNumber,
    required this.surroundingId,
    required this.images,
    required this.imageUrl,
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
  final String telephoneNumber;
  final int surroundingId;
  final List<int> images;
  final String? imageUrl;

  factory DigitalGuideResponseExtended.fromDigitalGuideResponse({
    required DigitalGuideResponse digitalGuideResponse,
    required String? imageUrl,
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
      telephoneNumber: digitalGuideResponse.telephoneNumber,
      surroundingId: digitalGuideResponse.surroundingId,
      images: digitalGuideResponse.images,
      imageUrl: imageUrl,
    );
  }
}
