import "package:dio/dio.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../../config/env.dart";

part "iparking_client.g.dart";

abstract class ParkingsConfig {
  static const parkingsRefreshInterval = Duration(seconds: 30);
  static final rootUrl = Env.iparkingUrl;
  static const soapEndpoint = "/modules/iparking/scripts/ipk_operations.php";
  static String get soapFullUrl => rootUrl + soapEndpoint;

  static final headers = {
    "Accept": "application/json",
    "Accept-Encoding": "gzip",
    "Accept-Language": "pl",
    "Content-Type": "application/json",
    "Referer": rootUrl,
    "X-Requested-With": "XMLHttpRequest",
    "Connection": "keep-alive",
  };
}

@riverpod
Dio iParkingClient(Ref ref) {
  return Dio(BaseOptions(baseUrl: ParkingsConfig.soapFullUrl, headers: ParkingsConfig.headers));
}
