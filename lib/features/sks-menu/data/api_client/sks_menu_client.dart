import "package:dio/dio.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../../config/env.dart";

abstract class SksMenuClientConfig {
  static final rootUrl = Env.sksUrl;
  static const mealsEndpoint = "/meals";
}

@riverpod
Dio sksClient(Ref ref) {
  return Dio(
    BaseOptions(
      baseUrl: SksMenuClientConfig.rootUrl,
    ),
  );
}
