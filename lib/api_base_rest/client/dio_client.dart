import "package:dio/dio.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

part "dio_client.g.dart";

@Riverpod(keepAlive: true)
Dio restClient(Ref ref) {
  return Dio();
}
