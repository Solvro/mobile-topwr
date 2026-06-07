import "dart:async";

import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:just_audio/just_audio.dart";
import "package:logger/logger.dart";

import "../../../../../../config/ui_config.dart";
import "../../../../../../theme/app_theme.dart";
import "../../../../../../utils/context_extensions.dart";
import "../../../../../../utils/duration_utils.dart";
import "../../../../../radio_luz/utils/just_audio_playback_errors.dart";

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
      void onStreamError(Object error, StackTrace stackTrace) {
        logAndRethrowJustAudioPlaybackError("MyAudioPlayer", error, stackTrace);
      }

      final stateSubscription = audioPlayer.playerStateStream.listen((state) {
        isPlaying.value = state.playing;
      }, onError: onStreamError);

      final durationSubscription = audioPlayer.durationStream.listen((duration) {
        totalTime.value = duration ?? Duration.zero;
      }, onError: onStreamError);

      final positionSubscription = audioPlayer.positionStream.listen((position) {
        currentTime.value = position;
      }, onError: onStreamError);

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
      } else if (audioUrl.isEmpty) {
        const message = "[MyAudioPlayer.togglePlayPause] empty audioUrl";
        Logger().w(message);
        throw StateError(message);
      } else {
        try {
          await audioPlayer.setUrl(audioUrl);
          await audioPlayer.play();
        } on PlayerException catch (error, stackTrace) {
          logAndRethrowJustAudioPlaybackError("MyAudioPlayer.togglePlayPause", error, stackTrace);
        }
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
          color: context.colorScheme.surfaceTint,
          borderRadius: BorderRadius.circular(DigitalGuideConfig.borderRadiusHuge),
        ),
        child: Row(
          children: [
            IconButton(
              tooltip: isPlaying.value ? context.localize.audio_player_pause : context.localize.audio_player_play,
              icon: Icon(isPlaying.value ? Icons.pause : Icons.play_arrow, semanticLabel: ""),
              color: context.colorScheme.onTertiary,
              onPressed: () async {
                unawaited(HapticFeedback.selectionClick());
                await togglePlayPause();
              },
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
                inactiveColor: context.colorScheme.outline,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
