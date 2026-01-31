import "package:freezed_annotation/freezed_annotation.dart";

part "now_playing.freezed.dart";
part "now_playing.g.dart";

@freezed
abstract class NowPlaying with _$NowPlaying {
  const factory NowPlaying({required String? now, required String? next}) = _NowPlaying;

  factory NowPlaying.fromJson(Map<String, dynamic> json) => _$NowPlayingFromJson(json);
}
