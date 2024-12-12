import "package:dio/dio.dart";
import "package:flutter/widgets.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "dio_client.dart";

class RestFrameworkOfflineException implements Exception {
  final String message;
  final String Function(BuildContext context) localizedMessage;
  final VoidCallback? onRetry;

  RestFrameworkOfflineException({
    required this.localizedMessage,
    this.onRetry,
    this.message = "No Internet connection",
  });

  @override
  String toString() => "RestFrameworkOfflineException: $message";
}

extension DioSafeRequestsX on Ref {
  Future<Response<T>> safeRequest<T>(
    Future<Response<T>> Function() request, {
    required String Function(BuildContext context) localizedMessage,
    VoidCallback? onRetry,
  }) async {
    try {
      return await request();
    } on DioException catch (_) {
      throw RestFrameworkOfflineException(
        localizedMessage: localizedMessage,
        onRetry: onRetry,
      );
    }
  }

  Future<Response<T>> safeGetWatch<T>(
    String url, {
    required String Function(BuildContext context) localizedMessage,
    VoidCallback? onRetry,
  }) async {
    final dio = watch(restClientProvider);
    return safeRequest(
      () => dio.get(url),
      localizedMessage: localizedMessage,
      onRetry: onRetry,
    );
  }
}
