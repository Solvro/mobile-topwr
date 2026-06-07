import "dart:io";

import "package:flutter/foundation.dart";
import "package:flutter_carplay/flutter_carplay.dart";

import "radio_audio_handler.dart";

class CarPlayService {
  final RadioAudioHandlerBridge _audioHandler;
  late final FlutterCarplay _carplay;

  CarPlayService(this._audioHandler);

  Future<void> initialize() async {
    if (kIsWeb || !Platform.isIOS) return;

    _carplay = FlutterCarplay();

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
