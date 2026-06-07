import "dart:async";
import "dart:io";

import "package:flutter/foundation.dart";
import "package:flutter_carplay/flutter_carplay.dart";

import "radio_audio_handler.dart";

class CarPlayService {
  final RadioAudioHandlerBridge _audioHandler;
  late final FlutterCarplay _carplay;
  var _initialized = false;

  CarPlayService(this._audioHandler);

  Future<void> initialize() async {
    if (kIsWeb || !Platform.isIOS) return;

    _carplay = FlutterCarplay();

    // Listen to connection changes to set up templates dynamically when CarPlay connects
    _carplay.addListenerOnConnectionChange(_onCarplayConnectionChange);

    // If CarPlay is already connected on startup, initialize immediately
    if (FlutterCarplay.connectionStatus == ConnectionStatusTypes.connected.name) {
      await _setupCarplayTemplate();
    }
  }

  void _onCarplayConnectionChange(ConnectionStatusTypes status) {
    if (status == ConnectionStatusTypes.connected) {
      unawaited(_setupCarplayTemplate());
    } else {
      _initialized = false;
    }
  }

  Future<void> _setupCarplayTemplate() async {
    if (_initialized) return;
    _initialized = true;

    await FlutterCarplay.setRootTemplate(
      rootTemplate: CPListTemplate(
        sections: [
          CPListSection(
            items: [
              CPListItem(
                text: "Radio LUZ",
                detailText: "Studenckie Radio",
                image: radioLuzArtwork,
                onPress: (complete, self) async {
                  try {
                    await _audioHandler.play();
                    await FlutterCarplay.showSharedNowPlaying();
                  } finally {
                    complete();
                  }
                },
              ),
            ],
          ),
        ],
        title: "ToPWR",
        systemIcon: "music.note",
      ),
      animated: false,
    );
    await _carplay.forceUpdateRootTemplate();
  }
}
