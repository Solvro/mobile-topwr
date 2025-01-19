import "dart:async";

import "package:audioplayers/audioplayers.dart";
import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";

import "../../../../../../config/ui_config.dart";
import "../../../../../../theme/app_theme.dart";
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

    useEffect(
      () {
        final stateSubscription =
            audioPlayer.onPlayerStateChanged.listen((state) {
          isPlaying.value = state == PlayerState.playing;
        });

        final durationSubscription =
            audioPlayer.onDurationChanged.listen((duration) {
          totalTime.value = duration;
        });

        final positionSubscription =
            audioPlayer.onPositionChanged.listen((position) {
          currentTime.value = position;
        });

        return () async {
          unawaited(stateSubscription.cancel());
          unawaited(durationSubscription.cancel());
          unawaited(positionSubscription.cancel());
          unawaited(audioPlayer.dispose());
        };
      },
      [audioPlayer],
    );

    final togglePlayPause = useCallback(
      () async {
        if (isPlaying.value) {
          await audioPlayer.pause();
        } else {
          await audioPlayer.play(UrlSource(audioUrl));
        }
      },
      [audioUrl],
    );

    final seekAudio = useCallback(
      (double value) async {
        final position = Duration(seconds: value.toInt());
        await audioPlayer.seek(position);
      },
      [],
    );

    return Container(
      padding: const EdgeInsets.all(DigitalGuideConfig.paddingSmall),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius:
            BorderRadius.circular(DigitalGuideConfig.borderRadiusHuge),
      ),
      child: Row(
        children: [
          IconButton(
            icon: Icon(isPlaying.value ? Icons.pause : Icons.play_arrow),
            color: context.colorTheme.blackMirage,
            onPressed: togglePlayPause,
          ),
          Text(
            "${formatDurationToMinutesString(currentTime.value)} / ${formatDurationToMinutesString(totalTime.value)}",
            style:
                TextStyle(fontSize: 14, color: context.colorTheme.blackMirage),
          ),
          const SizedBox(width: DigitalGuideConfig.heightTiny),
          Expanded(
            child: Slider(
              value: currentTime.value.inSeconds.toDouble(),
              max: totalTime.value.inSeconds.toDouble(),
              onChanged: seekAudio,
              activeColor: context.colorTheme.blackMirage,
              inactiveColor: Colors.grey[400],
            ),
          ),
        ],
      ),
    );
  }
}
