import "package:flutter/widgets.dart";
import "package:topwr/features/digital_guide/tabs/micronavigation/presentation/widgets/my_audio_player.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

@widgetbook.UseCase(name: "default", type: MyAudioPlayer)
Widget useCaseMyAudioPlayer(BuildContext context) {
  return const MyAudioPlayer(audioUrl: "https://example.com/audio.mp3");
}
