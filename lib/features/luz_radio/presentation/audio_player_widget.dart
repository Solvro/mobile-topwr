import "package:flutter/material.dart";
import "package:flutter_svg/svg.dart";

import "../../../gen/assets.gen.dart";
import "../../../theme/app_theme.dart";
import "../../../utils/context_extensions.dart";
import "../service/radio_player_service.dart";

class AudioPlayerWidget extends StatefulWidget {
  const AudioPlayerWidget({super.key});

  @override
  State<AudioPlayerWidget> createState() => _AudioPlayerWidgetState();
}

class _AudioPlayerWidgetState extends State<AudioPlayerWidget> {
  final _player = RadioPlayerService();
  var _isWaiting = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.colorTheme.orangePomegranadeLighter,
      width: double.infinity,
      height: 59,
      child: Row(
        children: [
          const SizedBox(width: 18),
          StreamBuilder<bool>(
            stream: _player.isPlayingStream,
            initialData: _player.isPlaying,
            builder: (_, snapshot) {
              final isPlaying = snapshot.data ?? false;
              return GestureDetector(
                onTap: () async {
                  if (isPlaying) {
                    setState(() {
                      _isWaiting = false;
                    });
                    await _player.pause();
                  } else {
                    setState(() {
                      _isWaiting = true;
                    });
                    await _player.play();
                  }
                },
                child: SizedBox(
                  width: 40,
                  child: isPlaying
                      ? SvgPicture.asset(Assets.svg.radioLuz.pauseIcon)
                      : (_isWaiting
                            ? const CircularProgressIndicator(color: Colors.black, strokeWidth: 2)
                            : SvgPicture.asset(Assets.svg.radioLuz.playIcon)),
                ),
              );
            },
          ),
          const SizedBox(width: 12),
          Expanded(child: Text(context.localize.radio_luz, maxLines: 1, overflow: TextOverflow.ellipsis)),
          const SizedBox(width: 24),
          SvgPicture.asset(Assets.svg.radioLuz.speakerIcon, width: 20),
          StreamBuilder<double>(
            stream: _player.volumeStream,
            initialData: _player.volume,
            builder: (_, snapshot) {
              final currentVolume = snapshot.data ?? 1.0;
              return SizedBox(
                // TODO(24bartixx): calculate width based on screen size
                width: 130,
                child: Slider(
                  value: currentVolume,
                  thumbColor: Colors.black,
                  activeColor: Colors.black,
                  onChanged: (newVolume) async {
                    await _player.setVolume(newVolume);
                  },
                ),
              );
            },
          ),
          const SizedBox(width: 24),
        ],
      ),
    );
  }
}
