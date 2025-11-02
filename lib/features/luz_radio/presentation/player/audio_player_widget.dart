import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";

import "../../../../config/ui_config.dart";
import "../../../../theme/app_theme.dart";
import "../../../../utils/context_extensions.dart";
import "../../../radio_luz/service/radio_player_controller.dart";
import "../../data/models/audio_player_strings.dart";

import "radio_player_control_button.dart";
import "radio_player_info.dart";
import "radio_player_slider.dart";

class AudioPlayerWidget extends HookConsumerWidget {
  const AudioPlayerWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.localize;
    final radioController = ref.watch(radioControllerProvider.notifier);
    final radioState = ref.watch(radioControllerProvider);

    useEffect(() {
      final audioPlayerStrings = AudioPlayerStrings(title: l10n.radio_luz_title, album: l10n.radio_luz_subtitle);
      radioController.init(audioPlayerStrings);
      return null;
    }, []);

    return Column(
      children: [
        Container(
          color: context.colorTheme.orangePomegranadeLighter,
          width: double.infinity,
          height: 59,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              spacing: RadioLuzConfig.spacingMedium,
              children: [
                RadioPlayerControlButton(
                  radioController: radioController,
                  isLoading: radioState.isLoading,
                  isPlaying: radioState.isPlaying,
                ),
                RadioPlayerSlider(radioController: radioController, volume: radioState.volume),
                const RadioPlayerInfo(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
