import "package:flutter/widgets.dart";
import "package:topwr/features/radio_luz/presentation/now_playing_section.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

@widgetbook.UseCase(name: "default", type: NowPlayingSection)
Widget useCaseNowPlayingSection(BuildContext context) {
  return const NowPlayingSection();
}
