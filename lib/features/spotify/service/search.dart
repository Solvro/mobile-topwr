import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";
import "../../../api_base_rest/client/offline_error.dart";
import "../../../config/env.dart";
import "auth.dart";

part 'search.g.dart';

@riverpod
Future<Map<String, dynamic>> spotifySong(Ref ref, String title, String artist) async {
  final apiUrl = "${Env.spotifyApiUrl}/search?q=${Uri.encodeComponent("$title $artist")}&type=track&limit=1";
  final token = await ref.read(spotifyProvider.future);
  print("Spotify Token: $token");
  final response = await ref.safeGetWatch<Map<String, dynamic>>(
    apiUrl,
    localizedMessage: (_) => "Unable to connect to Spotify services.",
    authHeader: (authorization: "Bearer $token"),
  );
  print("Spotify Response: ${response.data}");
  return response.data as Map<String, dynamic>;
}
