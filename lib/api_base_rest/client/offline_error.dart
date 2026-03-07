import "package:dio/dio.dart";
import "package:flutter/widgets.dart";
import "package:logger/logger.dart";

class RestFrameworkOfflineException implements Exception {
  final String message;
  final VoidCallback? onRetry;

  RestFrameworkOfflineException({this.onRetry, this.message = "No Internet connection"});

  @override
  String toString() => "RestFrameworkOfflineException: $message";
}

Future<Response<T>> safeRequest<T>(Future<Response<T>> Function() request, {VoidCallback? onRetry}) async {
  try {
    return await request();
  } on DioException catch (e) {
    Logger().e(e);
    throw RestFrameworkOfflineException(onRetry: onRetry);
  }
}

extension DioSafeRequestsX on Dio {
  Future<Response<T>> safeGet<T>(String url, {VoidCallback? onRetry}) {
    return safeRequest(() => get<T>(url), onRetry: onRetry);
  }
}
