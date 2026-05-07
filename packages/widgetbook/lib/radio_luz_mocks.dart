import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/material.dart";
import "package:topwr/features/radio_luz/data/domain/schedule_entity.dart";
import "package:topwr/features/radio_luz/data/models/audio_player_strings.dart";
import "package:topwr/features/radio_luz/data/models/history_entry.dart";
import "package:topwr/features/radio_luz/service/radio_player_controller.dart";
import "package:topwr/features/radio_luz/service/radio_state.dart";

final mockRadioController = FakeRadioController();

const mockHistoryEntries = IListConst<HistoryEntry>([
  HistoryEntry(
    date: "2026-05-06",
    time: TimeOfDay(hour: 10, minute: 12),
    artist: "Radio LUZ",
    title: "Poranek akademicki",
    album: "Studenckie Radio",
    duration: "03:42",
    label: "LUZ",
  ),
  HistoryEntry(
    date: "2026-05-06",
    time: TimeOfDay(hour: 10, minute: 16),
    artist: "Solvro Talks",
    title: "Technologie na kampusie",
    album: "Studenckie Radio",
    duration: "04:11",
    label: "LUZ",
  ),
  HistoryEntry(
    date: "2026-05-06",
    time: TimeOfDay(hour: 10, minute: 20),
    artist: "Akademicki Patrol",
    title: "Co slychac na PWr",
    album: "Studenckie Radio",
    duration: "02:58",
    label: "LUZ",
  ),
  HistoryEntry(
    date: "2026-05-06",
    time: TimeOfDay(hour: 10, minute: 24),
    artist: "Radio LUZ",
    title: "Na zywo ze studia",
    album: "Studenckie Radio",
    duration: "05:00",
    label: "LUZ",
  ),
  HistoryEntry(
    date: "2026-05-06",
    time: TimeOfDay(hour: 10, minute: 29),
    artist: "Politechnika FM",
    title: "Muzyka i rozmowy",
    album: "Studenckie Radio",
    duration: "03:36",
    label: "LUZ",
  ),
]);

const mockBroadcasts = [
  BroadcastEntity(
    id: 1,
    time: "10:00 - 11:00",
    thumbnail: "",
    title: "Politechnika FM",
    content: "Rozmowy o zyciu kampusu i projektach studenckich.",
    authors: "Radio LUZ",
    permalink: "",
    week: "1",
    isNow: true,
  ),
  BroadcastEntity(
    id: 2,
    time: "11:00 - 12:00",
    thumbnail: "",
    title: "LUZ Blues",
    content: "Autorska audycja muzyczna.",
    authors: "Radio LUZ",
    permalink: "",
    week: "1",
    isNow: false,
  ),
  BroadcastEntity(
    id: 3,
    time: "12:00 - 13:00",
    thumbnail: "",
    title: "Akademicki Patrol",
    content: "Najwazniejsze informacje dla studentow.",
    authors: "Radio LUZ",
    permalink: "",
    week: "1",
    isNow: false,
  ),
];

class FakeRadioController extends RadioController {
  var _state = const RadioState(volume: 0.65);
  var _isMountedByRiverpod = false;

  void _setFakeState(RadioState value) {
    _state = value;

    if (_isMountedByRiverpod) {
      super.state = value;
    }
  }

  @override
  Future<Uri> assetToFileUri(String assetPath) async => Uri(path: assetPath);

  @override
  RadioState build() {
    _isMountedByRiverpod = true;
    ref.onDispose(() => _isMountedByRiverpod = false);
    return _state;
  }

  @override
  void init(AudioPlayerStrings audioPlayerStrings) {}

  @override
  Future<void> pause() async {
    _setFakeState(_state.copyWith(isPlaying: false, isLoading: false));
  }

  @override
  Future<void> play() async {
    _setFakeState(_state.copyWith(isPlaying: true, isLoading: false));
  }

  @override
  Future<void> preload() async {}

  @override
  void rememberVolume(double newVolume) {
    _setFakeState(_state.copyWith(volume: newVolume, isMuted: newVolume <= 0.05));
  }

  @override
  Future<void> setVolume(double newVolume) async {
    rememberVolume(newVolume);
  }

  @override
  RadioState get state => _state;

  @override
  set state(RadioState value) {
    _setFakeState(value);
  }

  @override
  RadioState? get stateOrNull => _state;

  @override
  Future<void> toggleVolume() async {
    _setFakeState(_state.copyWith(isMuted: !_state.isMuted, volume: _state.isMuted ? 0.65 : 0));
  }
}
