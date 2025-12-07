import "package:flutter/material.dart";
import "package:flutter_svg/flutter_svg.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";

import "../../../theme/app_theme.dart";
import "../../../utils/context_extensions.dart";
import "../../../utils/launch_url_util.dart";
import "../../spotify/service/add_to_spotify.dart";

enum StreamingService {
  spotify(
    name: "Spotify",
    iconAsset: "assets/svg/streaming/spotify.svg",
    color: Color(0xFF1DB954),
    searchUrlTemplate: "https://open.spotify.com/search/{query}",
    inApp: true,
    function: findSpotifyTrack,
  ),
  appleMusic(
    name: "Apple Music",
    iconAsset: "assets/svg/streaming/apple_music.svg",
    color: Color(0xFFFC3C44),
    searchUrlTemplate: "https://music.apple.com/pl/search?term={query}",
  ),
  youtubeMusic(
    name: "YouTube Music",
    iconAsset: "assets/svg/streaming/youtube_music.svg",
    color: Color(0xFFFF0000),
    searchUrlTemplate: "https://music.youtube.com/search?q={query}",
  ),
  deezer(
    name: "Deezer",
    iconAsset: "assets/svg/streaming/deezer.svg",
    color: Color(0xFFA238FF),
    searchUrlTemplate: "https://www.deezer.com/search/{query}",
  ),
  tidal(
    name: "Tidal",
    iconAsset: "assets/svg/streaming/tidal.svg",
    color: Color(0xFF000000),
    searchUrlTemplate: "https://tidal.com/search?q={query}",
  );

  const StreamingService({
    required this.name,
    required this.iconAsset,
    required this.color,
    required this.searchUrlTemplate,
    this.inApp = false,
    this.function,
  });

  final String name;
  final String iconAsset;
  final Color color;
  final String searchUrlTemplate;
  final bool inApp;
  final Future<Map<String, dynamic>> Function(BuildContext, WidgetRef, String, String)? function;

  String getSearchUrl(String query) {
    return searchUrlTemplate.replaceAll("{query}", Uri.encodeComponent(query));
  }
}

class AddToStreamingSheet extends ConsumerWidget {
  const AddToStreamingSheet({super.key, required this.title, required this.artist});

  final String title;
  final String artist;

  static Future<void> show(BuildContext context, {required String title, required String artist}) {
    return showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => AddToStreamingSheet(title: title, artist: artist),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorTheme = context.colorTheme;
    final textTheme = context.textTheme;

    return Container(
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
                style: textTheme.body.copyWith(color: colorTheme.greyPigeon),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 24),
              ...StreamingService.values.map(
                (service) => _StreamingServiceTile(service: service, ref: ref, title: title, artist: artist),
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}

class _StreamingServiceTile extends StatefulWidget {
  const _StreamingServiceTile({required this.service, required this.ref, required this.title, required this.artist});

  final StreamingService service;
  final WidgetRef ref;
  final String title;
  final String artist;

  @override
  State<_StreamingServiceTile> createState() => _StreamingServiceTileState();
}

class _StreamingServiceTileState extends State<_StreamingServiceTile> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    final colorTheme = context.colorTheme;
    final textTheme = context.textTheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Material(
        color: colorTheme.greyLight,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          onTap: () async {
            setState(() {
              loading = true;
            });
            if (widget.service.function != null) {
              final Map<String, dynamic> result = await widget.service.function!(context, widget.ref, widget.title, widget.artist);
              if (result["found"] == true) {
                await widget.ref.launch(result["url"] as String);
                Navigator.of(context).pop();
              } else {
                await widget.ref.launch(widget.service.getSearchUrl("${widget.title} ${widget.artist}"));
                Navigator.of(context).pop();
              }
            } else {
              await widget.ref.launch(widget.service.getSearchUrl("${widget.title} ${widget.artist}"));
              Navigator.of(context).pop();
            }
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
                    color: widget.service.color.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      widget.service.iconAsset,
                      width: 24,
                      height: 24,
                      colorFilter: ColorFilter.mode(widget.service.color, BlendMode.srcIn),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(child: Text(widget.service.name, style: textTheme.title)),
                if(loading)
                  SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: colorTheme.greyPigeon,
                    ),
                  )
                else
                Icon(Icons.open_in_new, color: colorTheme.greyPigeon, size: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
