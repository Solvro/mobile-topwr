import "package:awesome_dio_interceptor/awesome_dio_interceptor.dart";
import "package:dio/dio.dart";
import "package:flutter/foundation.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "dio_logging_interceptor.dart";

part "dio_client.g.dart";

@Riverpod(keepAlive: true)
Dio restClient(Ref ref) {
  //Pass as argument FULL URL
  final dio = Dio();
  if (kDebugMode) {
    dio.interceptors.add(AwesomeDioInterceptor());
  }
  return dio;
}

typedef AuthHeader = ({String authorization});

@riverpod
Dio authRestClient(Ref ref, AuthHeader? authHeader) {
  final dio = ref.watch(restClientProvider);
  if (authHeader == null) return dio;
  dio.options.headers["Authorization"] = authHeader.authorization;
  return dio;
}
