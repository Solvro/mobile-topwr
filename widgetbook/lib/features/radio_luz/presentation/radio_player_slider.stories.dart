import "package:flutter/material.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:topwr/features/radio_luz/presentation/radio_player_slider.dart";
import "package:topwr/features/radio_luz/service/radio_player_controller.dart";
import "package:widgetbook/widgetbook.dart";

part "radio_player_slider.stories.g.dart";

/// Wraps [RadioPlayerSlider] with live [RadioController] from Riverpod (v3 used knobs; v4 cannot generate args for [RadioController]).
class RadioPlayerSliderStory extends ConsumerWidget {
  const RadioPlayerSliderStory({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final radioController = ref.watch(radioControllerProvider.notifier);
    final state = ref.watch(radioControllerProvider);
    return RadioPlayerSlider(radioController: radioController, volume: state.volume);
  }
}

const meta = Meta<RadioPlayerSliderStory>();

final $default = RadioPlayerSliderStoryStory();
