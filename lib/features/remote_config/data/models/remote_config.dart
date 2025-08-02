import "package:freezed_annotation/freezed_annotation.dart";

part "remote_config.freezed.dart";
part "remote_config.g.dart";

@freezed
abstract class RemoteConfig with _$RemoteConfig {
  const factory RemoteConfig({
    required int cmsReferenceNumber,
    required int daySwapLookahead,
    required int translatorReferenceNumber,
  }) = _RemoteConfig;

  factory RemoteConfig.fromJson(Map<String, dynamic> json) => _$RemoteConfigFromJson(json);
}
