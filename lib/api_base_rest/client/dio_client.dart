import "dart:io" show HttpClient;

import "package:dio/dio.dart";
import "package:dio/io.dart" show IOHttpClientAdapter;
import "package:flutter/foundation.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

part "dio_client.g.dart";

@Riverpod(keepAlive: true)
Dio restClient(Ref ref) {
  //Pass as argument FULL URL
  final dio = Dio();
  if (kDebugMode) {
    // weird shit
    // https://stackoverflow.com/questions/54285172/how-to-solve-flutter-certificate-verify-failed-error-while-performing-a-post-req
    // https://github.com/cfug/dio/issues/956
    (dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient =
        () => HttpClient()..badCertificateCallback = (cert, host, port) => true;
  }
  return dio;
}

typedef AuthHeader = ({String authotization});

@riverpod
Dio authRestClient(Ref ref, AuthHeader? authHeader) {
  final dio = ref.watch(restClientProvider);
  if (authHeader == null) return dio;
  dio.options.headers["Authorization"] = authHeader.authotization;
  return dio;
}
