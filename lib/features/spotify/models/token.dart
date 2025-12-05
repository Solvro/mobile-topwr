import 'package:freezed_annotation/freezed_annotation.dart';

part 'token.freezed.dart';
part 'token.g.dart';

@freezed
abstract class SpotifyTokenResponse with _$SpotifyTokenResponse {
  const factory SpotifyTokenResponse({
    @JsonKey(name: 'access_token') required String accessToken,
    @JsonKey(name: 'token_type') required String tokenType,
    @JsonKey(name: 'expires_in') required int expiresIn,
    String? scope,
  }) = _SpotifyTokenResponse;

  const SpotifyTokenResponse._();

  factory SpotifyTokenResponse.fromJson(Map<String, dynamic> json) =>
      _$SpotifyTokenResponseFromJson(json);
}