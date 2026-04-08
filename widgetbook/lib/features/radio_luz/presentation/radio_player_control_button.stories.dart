import "package:flutter/widgets.dart";
import "package:riverpod/riverpod.dart";
import "package:topwr/features/radio_luz/data/models/audio_player_strings.dart";
import "package:topwr/features/radio_luz/presentation/radio_player_control_button.dart";
import "package:topwr/features/radio_luz/service/radio_player_controller.dart";
import "package:topwr/features/radio_luz/service/radio_state.dart";
import "package:widgetbook/widgetbook.dart";

part "radio_player_control_button.stories.g.dart";

class FakeRadioController implements RadioController {
  // --- Controller stubs ---
  @override
  Future<void> play() async {}
  @override
  Future<void> pause() async {}
  @override
  RadioState build() => const RadioState();
  @override
  Future<Uri> assetToFileUri(String assetPath) async => Uri();
  @override
  Future<void> setVolume(double volume) async {}
  @override
  void rememberVolume(double newVolume) {}
  @override
  Future<void> toggleVolume() async {}
  @override
  Future<void> preload() async {}

  // --- Riverpod / Notifier stubs ---
  @override
  void Function() listenSelf(
    void Function(RadioState?, RadioState) listener, {
    void Function(Object, StackTrace)? onError,
  }) {
    return () {};
  }

  @override
  bool updateShouldNotify(oldValue, newValue) => false;
  @override
  void init(AudioPlayerStrings audioPlayerStrings) {}
  @override
  void runBuild() {}
  var _state = const RadioState();
  @override
  RadioState get state => _state;
  @override
  set state(RadioState value) {
    _state = value;
  }

  @override
  Ref get ref => throw UnimplementedError();
  @override
  RadioState? get stateOrNull => _state;
}

final _fakeRadioController = FakeRadioController();

const meta = Meta<RadioPlayerControlButton>();

final $default = RadioPlayerControlButtonStory(
  args: RadioPlayerControlButtonArgs(radioController: Arg.fixed(_fakeRadioController)),
);
