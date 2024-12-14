import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../../data/repository/digital_guide_repository.dart";
import "../models/digital_guide_evacuation.dart";

part "evacuation_repository.g.dart";

@riverpod
Future<DigitalGuideEvacuation> getDigitalGuideEvacuation(
  Ref ref,
  int buildingId,
) async {
  final building =
      await ref.watch(getDigitalGuideBuildingDataProvider(buildingId).future);
  final evacuationMapUrl =
      await ref.watch(getImageUrlProvider(building.evacuationMapId).future);

  return DigitalGuideEvacuation(
      evacuationDescription:
          building.translations.plTranslation.evacuationDescription,
      evacuationMapUrl: evacuationMapUrl,
    );
}
