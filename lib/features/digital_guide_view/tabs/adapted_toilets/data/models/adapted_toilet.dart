import "package:flutter/material.dart";

import "../../../../../../utils/context_extensions.dart";
import "adapted_toilet_not_full.dart";

class AdaptedToilet {
  const AdaptedToilet({
    required this.translations,
    required this.isAccessAccessibleForPwd,
    required this.hasAdditionalPurpose,
    required this.isNeedAuthorization,
    required this.isEntranceGraphicallyMarked,
    required this.isMarked,
    required this.imagesURLs,
    required this.doorsIndices,
  });

  final AdaptedToiletTranslations translations;
  final bool isAccessAccessibleForPwd;
  final int hasAdditionalPurpose;
  final String isNeedAuthorization;
  final bool isEntranceGraphicallyMarked;
  final bool isMarked;
  final List<String> imagesURLs;
  final List<int> doorsIndices;

  factory AdaptedToilet.create({
    required AdaptedToiletNotFull adaptedToiletNotFull,
    required List<String> imagesURLs,
  }) {
    return AdaptedToilet(
      translations: adaptedToiletNotFull.translations,
      isAccessAccessibleForPwd: adaptedToiletNotFull.isAccessAccessibleForPwd,
      hasAdditionalPurpose: adaptedToiletNotFull.hasAdditionalPurpose,
      isNeedAuthorization: adaptedToiletNotFull.isNeedAuthorization,
      isEntranceGraphicallyMarked:
          adaptedToiletNotFull.isEntranceGraphicallyMarked,
      isMarked: adaptedToiletNotFull.isMarked,
      imagesURLs: imagesURLs,
      doorsIndices: adaptedToiletNotFull.doorsIndices,
    );
  }
}

extension AdaptedToiletLocalization on AdaptedToilet {
  String getDescription(BuildContext context) {
    return switch (hasAdditionalPurpose) {
      1 => context.localize.adapted_toilet_description,
      2 => context.localize.adapted_toilet_description_men,
      3 => context.localize.adapted_toilet_description_women,
      _ => context.localize.adapted_toilet_description,
    };
  }
}
