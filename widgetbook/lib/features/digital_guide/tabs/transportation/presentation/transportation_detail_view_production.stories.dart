import "package:flutter/material.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:topwr/features/digital_guide/data/models/digital_guide_response.dart";
import "package:topwr/features/digital_guide/tabs/transportation/data/repository/transportation_repository.dart";
import "package:topwr/features/digital_guide/tabs/transportation/presentation/transportation_detail_view.dart";
import "package:widgetbook/widgetbook.dart";

part "transportation_detail_view_production.stories.g.dart";

class TransportationDetailViewProductionStory extends ConsumerWidget {
  const TransportationDetailViewProductionStory({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const demoGuideResponse = DigitalGuideResponse(
      id: 1,
      externalId: 1,
      translations: DigitalGuideTranslations(
        plTranslation: DigitalGuideTranslation(
          name: "Demo",
          extendedName: "Demo Extended",
          address: "123 Demo St",
          evacuationDescription: "Follow signs to exit.",
        ),
      ),
      numberOfStoreys: 1,
      canAssistanceDog: true,
      isInductionLoop: false,
      isMicroNavigationSystem: false,
      areGuidancePaths: false,
      areBrailleBoards: false,
      areLargeFontBoards: false,
      isSignLanguageInterpreter: false,
      areEmergencyChairs: false,
      phoneNumbers: ["000-000-000"],
      surroundingId: 1,
      images: [],
      evacuationMapId: 1,
      locationMapId: 1,
      levelsIndices: [1],
      accessId: 1,
      accessibilityLevelForMotorDisability: 1,
      accessibilityLevelForBlind: 1,
      accessibilityLevelForVisuallyImpaired: 1,
      accessibilityLevelForHardOfHearing: 1,
      accessibilityLevelForHighSensorySensitivity: 1,
      accessibilityLevelForCognitiveDifficulties: 1,
    );
    final asyncTransportation = ref.watch(transportationRepositoryProvider.call(demoGuideResponse));

    return asyncTransportation.when(
      data: (transportation) {
        return TransportationDetailView(transportation: transportation, isPublic: true);
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stackTrace) => Center(child: Text("Error loading transportation data: $error")),
    );
  }
}

const meta = Meta<TransportationDetailViewProductionStory>();

final $fromProduction = TransportationDetailViewProductionStoryStory();
