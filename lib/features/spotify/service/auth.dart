import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";
import "../../../../config/env.dart";
import "../../../api_base_rest/cache/cache.dart";
import "../../../api_base_rest/client/json.dart";
import "../../../config/ttl_config.dart";
import "../models/token.dart";

part "auth.g.dart";

@riverpod
Future<String> spotify(Ref ref) async {
  final apiUrl =
      "${Env.spotifyAccountsUrl}/token?grant_type=client_credentials&client_id=${Env.spotifyClientId}&client_secret=${Env.spotifyClientSecret}";
  final result = await ref.postAndCacheData(
    apiUrl,
    SpotifyTokenResponse.fromJson,
    ttlDays: TtlDays.defaultOneHour,
    extraValidityCheck: (_) => true,
    localizedOfflineMessage: (_) => "Unable to connect to Spotify services.",
    onRetry: ref.invalidateSelf,
    headers: {"Content-Type": "application/x-www-form-urlencoded"},
  );
  return result.castAsObject.accessToken;
}
