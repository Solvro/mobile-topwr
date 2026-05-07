import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/widgets.dart";
import "package:topwr/features/digital_guide/tabs/entraces/data/models/digital_guide_entrace.dart";
import "package:topwr/features/digital_guide/tabs/entraces/presentation/digital_guide_entrance_widget.dart";
import "package:widgetbook/widgetbook.dart";

part "digital_guide_entrance_widget.stories.g.dart";

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

const meta = Meta<DigitalGuideEntranceWidget>();

final $default = DigitalGuideEntranceWidgetStory(
  args: DigitalGuideEntranceWidgetArgs(entrance: Arg.fixed(mockDigitalGuideEntrace)),
);
