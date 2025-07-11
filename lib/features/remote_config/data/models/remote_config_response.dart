import "package:freezed_annotation/freezed_annotation.dart";

import "remote_config.dart";

part "remote_config_response.freezed.dart";
part "remote_config_response.g.dart";

@freezed
abstract class RemoteConfigResponse with _$RemoteConfigResponse {
  const factory RemoteConfigResponse({required RemoteConfig data}) = _RemoteConfigResponse;

  factory RemoteConfigResponse.fromJson(Map<String, dynamic> json) => _$RemoteConfigResponseFromJson(json);
}
