import "package:dio/dio.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../config/env.dart";

part "sks_api_client.g.dart";

@riverpod
Dio sksClient(Ref ref) {
  return Dio(
    BaseOptions(
      baseUrl: Env.sksUrl,
    ),
  );
}
