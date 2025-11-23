import "package:dio/dio.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

part "dio_client.g.dart";

@Riverpod(keepAlive: true)
Dio restClient(Ref ref) {
  //Pass as argument FULL URL
  return Dio();
}

typedef AuthHeader = ({String authorization});

@riverpod
Dio authRestClient(Ref ref, AuthHeader? authHeader) {
  final dio = ref.watch(restClientProvider);
  if (authHeader == null) return dio;
  dio.options.headers["Authorization"] = authHeader.authorization;
  return dio;
}
