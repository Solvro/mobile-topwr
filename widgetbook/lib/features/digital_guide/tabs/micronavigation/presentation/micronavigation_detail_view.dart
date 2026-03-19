import "package:flutter/widgets.dart";
import "package:topwr/features/digital_guide/tabs/micronavigation/data/models/micronavigation_response.dart";
import "package:topwr/features/digital_guide/tabs/micronavigation/presentation/micronavigation_detail_view.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

const mockMicronavigationResponse = MicronavigationResponse(
  id: 1,
  location: 101,
  nameOverride: MicronavigationTranslations(
    pl: "Nawigacja PL",
    en: "Navigation EN",
    nb: "Navigering NB",
    de: "Navigation DE",
    uk: "Навігація UA",
  ),
  webContent: MicronavigationTranslations(
    pl: "Zawartość Web PL",
    en: "Web Content EN",
    nb: "Webinnhold NB",
    de: "Web-Inhalt DE",
    uk: "Веб-контент UA",
  ),
  languages: [
    MicronavigationLanguage(id: 1, langCode: "en", text: "English content", sound: "sound_en.mp3", order: 1),
    MicronavigationLanguage(id: 2, langCode: "pl", text: "Polska treść", order: 2),
    MicronavigationLanguage(id: 3, langCode: "de", order: 3),
  ],
);

@widgetbook.UseCase(name: "default", type: MicronavigationDetailView)
Widget useCaseMicronavigationDetailView(BuildContext context) {
  return const MicronavigationDetailView(micronavigationResponse: mockMicronavigationResponse);
}
