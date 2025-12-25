import "package:flutter/material.dart";

import "../../../gen/assets.gen.dart";
import "../../../theme/app_theme.dart";

enum StreamingService {
  spotify(name: "Spotify", searchUrlBuilder: _spotifySearchUrl),
  appleMusic(name: "Apple Music", searchUrlBuilder: _appleMusicSearchUrl),
  youtubeMusic(name: "YouTube Music", searchUrlBuilder: _youtubeMusicSearchUrl),
  deezer(name: "Deezer", searchUrlBuilder: _deezerSearchUrl),
  tidal(name: "Tidal", searchUrlBuilder: _tidalSearchUrl);

  const StreamingService({required this.name, required this.searchUrlBuilder});

  final String name;
  final String Function(String query) searchUrlBuilder;

  String get iconAsset => switch (this) {
    StreamingService.spotify => Assets.svg.streaming.spotify,
    StreamingService.appleMusic => Assets.svg.streaming.appleMusic,
    StreamingService.youtubeMusic => Assets.svg.streaming.youtubeMusic,
    StreamingService.deezer => Assets.svg.streaming.deezer,
    StreamingService.tidal => Assets.svg.streaming.tidal,
  };

  Color getColor(BuildContext context) {
    final colorTheme = context.colorScheme;
    return switch (this) {
      StreamingService.spotify => colorTheme.tertiaryContainer,
      StreamingService.appleMusic => colorTheme.onTertiaryContainer,
      StreamingService.youtubeMusic => Colors.red,
      StreamingService.deezer => colorTheme.scrim,
      StreamingService.tidal => Colors.black,
    };
  }

  static String _spotifySearchUrl(String query) => "https://open.spotify.com/search/${Uri.encodeComponent(query)}";

  static String _appleMusicSearchUrl(String query) =>
      "https://music.apple.com/pl/search?term=${Uri.encodeComponent(query)}";

  static String _youtubeMusicSearchUrl(String query) =>
      "https://music.youtube.com/search?q=${Uri.encodeComponent(query)}";

  static String _deezerSearchUrl(String query) => "https://www.deezer.com/search/${Uri.encodeComponent(query)}";

  static String _tidalSearchUrl(String query) => "https://tidal.com/search?q=${Uri.encodeComponent(query)}";
}
