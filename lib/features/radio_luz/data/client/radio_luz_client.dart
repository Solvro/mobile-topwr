import "package:dio/dio.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../../config/env.dart";
import "../../../../utils/web_proxy_url.dart";

part "radio_luz_client.g.dart";

Dio createRadioLuzDio() {
  final options = BaseOptions(
    baseUrl: proxyUrlOnWeb(Env.radioLuzApiUrl, sourceHost: "radioluz.pl", proxyPath: "radioluz"),
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
    headers: {
      "User-Agent": "RadioLuzApp/1.0 (Dart Dio)",
      "Accept": "*/*",
      "Content-Type": "application/x-www-form-urlencoded",
    },
  );

  return Dio(options);
}

@riverpod
Dio radioLuzClient(Ref ref) {
  return createRadioLuzDio();
}
