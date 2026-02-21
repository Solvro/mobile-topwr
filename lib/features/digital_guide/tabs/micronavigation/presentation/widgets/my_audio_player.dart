import "dart:async";

import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:just_audio/just_audio.dart";

import "../../../../../../config/ui_config.dart";
import "../../../../../../theme/app_theme.dart";
import "../../../../../../utils/context_extensions.dart";
import "../../../../../../utils/duration_utils.dart";

class MyAudioPlayer extends HookWidget {
  final String audioUrl;

  const MyAudioPlayer({super.key, required this.audioUrl});

  @override
  Widget build(BuildContext context) {
    final audioPlayer = useMemoized(AudioPlayer.new);
    final isPlaying = useState(false);
    final currentTime = useState(Duration.zero);
    final totalTime = useState(Duration.zero);

    useEffect(() {
      final stateSubscription = audioPlayer.playerStateStream.listen((state) {
        isPlaying.value = state.playing;
      });

      final durationSubscription = audioPlayer.durationStream.listen((duration) {
        totalTime.value = duration ?? Duration.zero;
      });

      final positionSubscription = audioPlayer.positionStream.listen((position) {
        currentTime.value = position;
      });

      return () {
        unawaited(stateSubscription.cancel());
        unawaited(durationSubscription.cancel());
        unawaited(positionSubscription.cancel());
        unawaited(audioPlayer.dispose());
      };
    }, [audioPlayer]);

    final togglePlayPause = useCallback(() async {
      if (isPlaying.value) {
        await audioPlayer.pause();
      } else {
        await audioPlayer.setUrl(audioUrl);
        await audioPlayer.play();
      }
    }, [audioUrl]);

    final seekAudio = useCallback((double value) async {
      final position = Duration(seconds: value.toInt());
      await audioPlayer.seek(position);
    }, []);

    return Semantics(
      container: true,
      label: "${context.localize.audio_message} ${context.localize.audio_message_comment_screen_reader}",
      child: Container(
        padding: const EdgeInsets.all(DigitalGuideConfig.paddingSmall),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(DigitalGuideConfig.borderRadiusHuge),
        ),
        child: Row(
          children: [
            IconButton(
              icon: Icon(isPlaying.value ? Icons.pause : Icons.play_arrow),
              color: context.colorScheme.onTertiary,
              onPressed: togglePlayPause,
            ),
            ExcludeSemantics(
              child: Text(
                "${formatDurationToMinutesString(currentTime.value)} / ${formatDurationToMinutesString(totalTime.value)}",
                style: TextStyle(fontSize: 14, color: context.colorScheme.onTertiary),
              ),
            ),
            const SizedBox(width: DigitalGuideConfig.heightTiny),
            Expanded(
              child: Slider(
                semanticFormatterCallback: (value) => context.localize.audio_player_slider(value),
                value: currentTime.value.inSeconds.toDouble(),
                max: totalTime.value.inSeconds.toDouble(),
                onChanged: seekAudio,
                activeColor: context.colorScheme.onTertiary,
                inactiveColor: Colors.grey[400],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
