import "package:flutter/widgets.dart";
import "package:topwr/features/digital_guide/tabs/lodge/data/models/digital_guide_lodge.dart";
import "package:topwr/features/digital_guide/tabs/structure/presentation/views/lodge_view.dart";
import "package:widgetbook/widgetbook.dart";

part "lodge_view.stories.g.dart";

const _mockLodge = DigitalGuideLodge(
  id: 1,
  translations: DigitalGuideTranslationsLodge(
    pl: DigitalGuideTranslationLodge(
      location: "Main hall",
      workingDaysAndHours: "Mon–Fri",
      comment: "Punkt informacyjny znajduje się przy głównym wejściu.",
      areAccessBarriersComment: "Brak progów i przeszkód na dojściu.",
      isMovementSpaceComment: "Zapewniona przestrzeń manewrowa przed ladą.",
      isSpaceUnderCounterComment: "Dostępna przestrzeń pod ladą dla użytkowników wózków.",
      isVisibleFromAfarComment: "Lada widoczna z głównego ciągu komunikacyjnego.",
      isGoodLitComment: "Strefa obsługi jest dobrze doświetlona.",
    ),
  ),
  areAccessBarriers: "no",
  isMovementSpace: "yes",
  counterHeight: 90,
  isSpaceUnderCounter: "yes",
  isVisibleFromAfar: "yes",
  isGoodLit: "yes",
  imagesIds: [8],
);

const meta = Meta(LodgeView.new);

final $default = LodgeViewStory(args: LodgeViewArgs(lodge: Arg.fixed(_mockLodge)));
