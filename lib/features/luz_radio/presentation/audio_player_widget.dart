import "dart:async";

import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:flutter_svg/svg.dart";

import "../../../gen/assets.gen.dart";
import "../../../theme/app_theme.dart";
import "../../../utils/context_extensions.dart";
import "../service/radio_player_controller.dart";

class AudioPlayerWidget extends ConsumerStatefulWidget {
  const AudioPlayerWidget({super.key});

  @override
  ConsumerState<AudioPlayerWidget> createState() => _AudioPlayerWidgetState();
}

class _AudioPlayerWidgetState extends ConsumerState<AudioPlayerWidget> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    unawaited(ref.read(radioControllerProvider.notifier).init(context.localize));
  }

  @override
  Widget build(BuildContext context) {
    final radioState = ref.watch(radioControllerProvider);
    final radioController = ref.watch(radioControllerProvider.notifier);

    return Container(
      color: context.colorTheme.orangePomegranadeLighter,
      width: double.infinity,
      height: 59,
      child: Row(
        children: [
          const SizedBox(width: 18),
          SizedBox.square(
            dimension: 40,
            child: radioState.isLoading
                ? const Padding(
                    padding: EdgeInsets.all(5),
                    child: CircularProgressIndicator(color: Colors.black, strokeWidth: 2),
                  )
                : GestureDetector(
                    onTap: () async {
                      if (radioState.isPlaying) {
                        await radioController.pause(context.localize);
                      } else {
                        await radioController.play(context.localize);
                      }
                    },
                    child: radioState.isPlaying
                        ? SvgPicture.asset(Assets.svg.radioLuz.pauseIcon)
                        : SvgPicture.asset(Assets.svg.radioLuz.playIcon),
                  ),
          ),
          const SizedBox(width: 12),
          Expanded(child: Text(context.localize.radio_luz_player_title, maxLines: 1, overflow: TextOverflow.ellipsis)),
          const SizedBox(width: 24),
          SvgPicture.asset(Assets.svg.radioLuz.speakerIcon, width: 20),
          SizedBox(
            width: MediaQuery.sizeOf(context).width * 0.3,
            child: Slider(
              value: radioState.volume,
              thumbColor: Colors.black,
              activeColor: Colors.black,
              onChanged: (newVolume) async {
                await radioController.setVolume(newVolume);
              },
            ),
          ),
          const SizedBox(width: 24),
        ],
      ),
    );
  }
}
