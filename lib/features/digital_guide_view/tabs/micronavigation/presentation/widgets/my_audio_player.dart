import "package:audioplayers/audioplayers.dart";
import "package:flutter/material.dart";

import "../../../../../../config/ui_config.dart";
import "../../../../../../theme/app_theme.dart";

class MyAudioPlayer extends StatefulWidget {
  final String audioUrl;

  const MyAudioPlayer({super.key, required this.audioUrl});

  @override
  MyAudioPlayerState createState() => MyAudioPlayerState();
}

class MyAudioPlayerState extends State<MyAudioPlayer> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool isPlaying = false;
  Duration currentTime = Duration.zero;
  Duration totalTime = Duration.zero;

  @override
  void initState() {
    super.initState();

    _audioPlayer.onPlayerStateChanged.listen((state) {
      setState(() {
        isPlaying = state == PlayerState.playing;
      });
    });

    _audioPlayer.onDurationChanged.listen((duration) {
      setState(() {
        totalTime = duration;
      });
    });

    _audioPlayer.onPositionChanged.listen((position) {
      setState(() {
        currentTime = position;
      });
    });
  }

  @override
  Future<void> dispose() async {
    await _audioPlayer.dispose();
    super.dispose();
  }

  // Play or pause the audio
  Future<void> _togglePlayPause() async {
    if (isPlaying) {
      await _audioPlayer.pause();
    } else {
      await _audioPlayer.play(UrlSource(widget.audioUrl));
    }
  }

  Future<void> _seekAudio(double value) async {
    final position = Duration(seconds: value.toInt());
    await _audioPlayer.seek(position);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(DigitalGuideConfig.paddingSmall),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          IconButton(
            icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
            color: context.colorTheme.blackMirage,
            onPressed: _togglePlayPause,
          ),
          Text(
            "${_formatTime(currentTime)} / ${_formatTime(totalTime)}",
            style:
                TextStyle(fontSize: 14, color: context.colorTheme.blackMirage),
          ),
          const SizedBox(width: DigitalGuideConfig.heightTiny),
          Expanded(
            child: Slider(
              value: currentTime.inSeconds.toDouble(),
              max: totalTime.inSeconds.toDouble(),
              onChanged: _seekAudio,
              activeColor: context.colorTheme.blackMirage,
              inactiveColor: Colors.grey[400],
            ),
          ),
        ],
      ),
    );
  }

  String _formatTime(Duration duration) {
    final minutes = duration.inMinutes;
    final seconds = duration.inSeconds % 60;
    return "$minutes:${seconds.toString().padLeft(2, '0')}";
  }
}
