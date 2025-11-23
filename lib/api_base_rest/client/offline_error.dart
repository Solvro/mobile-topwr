import "package:dio/dio.dart";
import "package:flutter/widgets.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:logger/logger.dart";

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
    } on DioException catch (e) {
      Logger().e(e);
      throw RestFrameworkOfflineException(localizedMessage: localizedMessage, onRetry: onRetry);
    }
  }

  Future<Response<T>> safeGetWatch<T>(
    String url, {
    required String Function(BuildContext context) localizedMessage,
    VoidCallback? onRetry,
    AuthHeader? authHeader,
  }) {
    final dio = watch(authRestClientProvider(authHeader));
    return safeRequest(() => dio.get<T>(url), localizedMessage: localizedMessage, onRetry: onRetry);
  }

  Future<Response<T>> safePostWatch<T>(
    String url, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    required String Function(BuildContext context) localizedMessage,
    VoidCallback? onRetry,
    AuthHeader? authHeader,
    Map<String, dynamic>? headers,
  }) {
    final dio = watch(authRestClientProvider(authHeader));
    return safeRequest(
      () => dio.post<T>(url, data: data, queryParameters: queryParameters, options: headers != null ? Options(headers: headers) : null),
      localizedMessage: localizedMessage,
      onRetry: onRetry,
    );
  }
}
