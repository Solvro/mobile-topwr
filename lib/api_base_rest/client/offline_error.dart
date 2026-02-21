import "package:dio/dio.dart";
import "package:flutter/widgets.dart";
import "package:logger/logger.dart";

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

extension DioSafeRequestsX on Dio {
  Future<Response<T>> safeGet<T>(
    String url, {
    required String Function(BuildContext context) localizedMessage,
    VoidCallback? onRetry,
  }) {
    return safeRequest(() => get<T>(url), localizedMessage: localizedMessage, onRetry: onRetry);
  }
}
