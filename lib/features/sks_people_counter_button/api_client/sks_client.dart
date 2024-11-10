import "package:dio/dio.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../config/env.dart";

part "sks_client.g.dart";

abstract class SksClientConfig {
  static final rootUrl = Env.sksUrl;
  static const latestDataEndpoint = "sks-users/current/";
}

@riverpod
Dio sksClient(Ref ref) {
  return Dio(
    BaseOptions(
      baseUrl: SksClientConfig.rootUrl,
    ),
  );
}
