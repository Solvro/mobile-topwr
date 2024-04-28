import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../api_base/config.dart';

part "iparking_client.g.dart";

abstract class IParkingConfig {
  static const parkingsRefreshInterval = Duration(minutes: 1);
  static final rootUrl = ApiBaseEnv.iparkingUrl;
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
Dio iParkingClient(IParkingClientRef ref) {
  return Dio(
    BaseOptions(
      baseUrl: IParkingConfig.soapFullUrl,
      headers: IParkingConfig.headers,
    ),
  );
}