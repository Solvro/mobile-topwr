import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/widgets.dart";
import "package:topwr/features/digital_guide/tabs/entraces/data/models/digital_guide_entrace.dart";
import "package:topwr/features/digital_guide/tabs/entraces/presentation/entraces_detail_view.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

const mockDigitalGuideEntrace = DigitalGuideEntrace(
  id: 1,
  translations: DigitalGuideTranslationsEntrace(
    pl: DigitalGuideTranslationEntrace(
      name: "Entrance Name",
      location: "Location 1",
      isMainComment: "",
      isForPersonelComment: "",
      isBuildingMarkedFromEntranceComment: "",
      isBuildingMarkedInEnComment: "",
      isLitComment: "",
      isEmergencyExitComment: "",
      isProtectionFromWeatherComment: "",
      isSolidSurfaceComment: "",
      areDifferentTypesOfSurfaceComment: "",
      areBenchesComment: "",
      entranceThreats: "",
      hasSoundTransmitterComment: null,
      hasTactilePavingComment: "",
      comment: "",
    ),
  ),
  orderNumber: 1,
  isMain: "yes",
  isAccessible: "yes",
  isForPersonel: "no",
  isBuildingMarkedFromEntrance: "yes",
  isBuildingMarkedInEn: "no",
  isLit: "yes",
  isEmergencyExit: "no",
  isProtectionFromWeather: "yes",
  isSolidSurface: "yes",
  areDifferentTypesOfSurface: "no",
  areBenches: "yes",
  numberOfDoors: 1,
  doorsDistance: "10m",
  hasSoundTransmitter: null,
  hasTactilePaving: "no",
  building: null,
  stairsIndices: IListConst([]),
  liftsIndices: IListConst([]),
  doorsIndices: IListConst([]),
  rampsIndices: IListConst([]),
  imagesIndices: IListConst([]),
);

@widgetbook.UseCase(name: "default", type: DigitalGuideEntranceDetailsView)
Widget useCaseDigitalGuideEntranceDetailsView(BuildContext context) {
  return const DigitalGuideEntranceDetailsView(entrance: mockDigitalGuideEntrace);
}
