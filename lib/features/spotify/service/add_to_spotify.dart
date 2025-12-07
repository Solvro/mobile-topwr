import "package:flutter/material.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "../service/search.dart";

Future<Map<String, dynamic>> findSpotifyTrack(BuildContext context, WidgetRef ref, String title, String artist) async {
  final Map<String, dynamic> result = await ref.read(spotifySongProvider(title, artist).future);
  final tracks = result["tracks"]["items"] as List;
  if (tracks.isNotEmpty) {
    final track = tracks.first;
    if ((track["name"] as String?)?.toLowerCase().contains(title.toLowerCase()) ?? false) {
      final trackUrl = track["external_urls"]["spotify"] as String;
      return {
        "found": true,
        "url": trackUrl,
      };
    }
  } 
  return {
    "found": false,
    "url": "",
  };
}
