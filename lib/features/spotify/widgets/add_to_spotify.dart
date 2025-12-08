import "package:flutter/material.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "../../../utils/launch_url_util.dart";
import "../service/search.dart";

class AddToSpotify extends ConsumerWidget {
  const AddToSpotify({super.key, required this.title, required this.artist, required this.color});

  final String title;
  final String artist;
  final Color color;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IconButton(
      icon: Icon(Icons.add, color: color),
      onPressed: () async {
        final Map<String, dynamic> result = await ref.read(spotifySongProvider(title, artist).future);
        final tracks = result["tracks"]["items"] as List;
        if (tracks.isNotEmpty) {
          final track = tracks.first;
          print(track["external_urls"].toString());
          if ((track["name"] as String?)?.toLowerCase().contains(title.toLowerCase()) ?? false) {
            final trackUrl = track["external_urls"]["spotify"] as String;
            await ref.launch(trackUrl);
          } else {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text("Nie znaleziono utworu w Spotify.")));
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Nie znaleziono utworu w Spotify.")));
        }
      },
    );
  }
}
