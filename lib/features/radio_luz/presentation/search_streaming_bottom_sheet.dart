import "package:flutter/material.dart";
import "package:flutter_svg/flutter_svg.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";

import "../../../theme/app_theme.dart";
import "../../../utils/context_extensions.dart";
import "../../../utils/launch_url_util.dart";

enum StreamingService {
  spotify(
    name: "Spotify",
    iconAsset: "assets/svg/streaming/spotify.svg",
    searchUrlBuilder: _spotifySearchUrl,
  ),
  appleMusic(
    name: "Apple Music",
    iconAsset: "assets/svg/streaming/apple_music.svg",
    searchUrlBuilder: _appleMusicSearchUrl,
  ),
  youtubeMusic(
    name: "YouTube Music",
    iconAsset: "assets/svg/streaming/youtube_music.svg",
    searchUrlBuilder: _youtubeMusicSearchUrl,
  ),
  deezer(
    name: "Deezer",
    iconAsset: "assets/svg/streaming/deezer.svg",
    searchUrlBuilder: _deezerSearchUrl,
  ),
  tidal(
    name: "Tidal",
    iconAsset: "assets/svg/streaming/tidal.svg",
    searchUrlBuilder: _tidalSearchUrl,
  );

  const StreamingService({
    required this.name,
    required this.iconAsset,
    required this.searchUrlBuilder,
  });

  final String name;
  final String iconAsset;
  final String Function(String query) searchUrlBuilder;

  String getSearchUrl(String query) {
    return searchUrlBuilder(query);
  }

  Color getColor(BuildContext context) {
    final colorTheme = context.colorTheme;
    return switch (this) {
      StreamingService.spotify => colorTheme.spotifyGreen,
      StreamingService.appleMusic => colorTheme.appleMusicRed,
      StreamingService.youtubeMusic => Colors.red,
      StreamingService.deezer => colorTheme.deezerPurple,
      StreamingService.tidal => Colors.black,
    };
  }

  static String _spotifySearchUrl(String query) =>
      "https://open.spotify.com/search/${Uri.encodeComponent(query)}";
  
  static String _appleMusicSearchUrl(String query) =>
      "https://music.apple.com/pl/search?term=${Uri.encodeComponent(query)}";
  
  static String _youtubeMusicSearchUrl(String query) =>
      "https://music.youtube.com/search?q=${Uri.encodeComponent(query)}";
  
  static String _deezerSearchUrl(String query) =>
      "https://www.deezer.com/search/${Uri.encodeComponent(query)}";
  
  static String _tidalSearchUrl(String query) =>
      "https://tidal.com/search?q=${Uri.encodeComponent(query)}";
}

class SearchStreamingBottomSheet extends ConsumerWidget {
  const SearchStreamingBottomSheet ({super.key, required this.title, required this.artist});

  final String title;
  final String artist;

  static Future<void> show(BuildContext context, {required String title, required String artist}) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (context) => SearchStreamingBottomSheet(title: title, artist: artist),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorTheme = context.colorTheme;
    final textTheme = context.textTheme;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: colorTheme.whiteSoap,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 36,
                height: 4,
                decoration: BoxDecoration(
                  color: colorTheme.blackMirage.withValues(alpha: 0.16),
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
              const SizedBox(height: 16),
              Text(context.localize.add_to_streaming_head, style: textTheme.headline),
              const SizedBox(height: 8),
              Text(
                "$title - $artist",
                style: textTheme.body,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 24),
              ...StreamingService.values.map(
                (service) => _StreamingServiceTile(service: service, title: title, artist: artist),
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}

class _StreamingServiceTile extends ConsumerWidget {
  const _StreamingServiceTile({required this.service, required this.title, required this.artist});

  final StreamingService service;
  final String title;
  final String artist;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorTheme = context.colorTheme;
    final textTheme = context.textTheme;
    final serviceColor = service.getColor(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Material(
        color: colorTheme.greyLight,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          onTap: () async {
            await ref.launch(service.getSearchUrl("$title $artist"));
          },
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: serviceColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      service.iconAsset,
                      width: 24,
                      height: 24,
                      colorFilter: ColorFilter.mode(serviceColor, BlendMode.srcIn),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(child: Text(service.name, style: textTheme.title)),
                Icon(Icons.open_in_new, color: colorTheme.greyPigeon, size: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
