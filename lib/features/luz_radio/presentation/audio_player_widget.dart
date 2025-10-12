import "package:flutter/material.dart";
import "package:flutter_svg/svg.dart";
import "package:just_audio/just_audio.dart";

import "../../../gen/assets.gen.dart";
import "../../../theme/app_theme.dart";
import "../../../utils/context_extensions.dart";
import "../service/radio_player_service.dart";

class AudioPlayerWidget extends StatelessWidget {
  AudioPlayerWidget({super.key});

  final _playerService = RadioPlayerService();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.colorTheme.orangePomegranadeLighter,
      width: double.infinity,
      height: 59,
      child: Row(
        children: [
          const SizedBox(width: 18),
          SizedBox(
            width: 40,
            height: 40,
            child: StreamBuilder<PlayerState>(
              stream: _playerService.player.playerStateStream,
              initialData: _playerService.player.playerState,
              builder: (_, snapshot) {
                final playerState = snapshot.data;
                final isPlaying = playerState?.playing ?? false;
                final processingState = playerState?.processingState;

                final isLoading =
                    processingState == ProcessingState.loading || processingState == ProcessingState.buffering;

                if (isLoading) {
                  return const Padding(
                    padding: EdgeInsets.all(5),
                    child: CircularProgressIndicator(color: Colors.black, strokeWidth: 2),
                  );
                }

                final iconButton = isPlaying
                    ? SvgPicture.asset(Assets.svg.radioLuz.pauseIcon)
                    : SvgPicture.asset(Assets.svg.radioLuz.playIcon);

                return GestureDetector(
                  onTap: () async {
                    if (isPlaying) {
                      await _playerService.pause();
                    } else {
                      await _playerService.play(context);
                    }
                  },
                  child: iconButton,
                );
              },
            ),
          ),
          const SizedBox(width: 12),
          Expanded(child: Text(context.localize.radio_luz, maxLines: 1, overflow: TextOverflow.ellipsis)),
          const SizedBox(width: 24),
          SvgPicture.asset(Assets.svg.radioLuz.speakerIcon, width: 20),
          StreamBuilder<double>(
            stream: _playerService.volumeStream,
            initialData: _playerService.volume,
            builder: (_, snapshot) {
              final currentVolume = snapshot.data ?? 1.0;
              return SizedBox(
                width: MediaQuery.of(context).size.width * 0.25,
                child: Slider(
                  value: currentVolume,
                  thumbColor: Colors.black,
                  activeColor: Colors.black,
                  onChanged: (newVolume) async {
                    await _playerService.setVolume(newVolume);
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
