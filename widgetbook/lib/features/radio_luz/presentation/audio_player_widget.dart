import "package:flutter/widgets.dart";
import "package:topwr/features/radio_luz/presentation/audio_player_widget.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

@widgetbook.UseCase(name: "default", type: AudioPlayerWidget)
Widget useCaseAudioPlayerWidget(BuildContext context) {
  return const AudioPlayerWidget();
}
