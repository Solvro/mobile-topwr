import "package:flutter/foundation.dart";

String proxyUrlOnWeb(String url, {required String sourceHost, required String proxyPath}) {
  if (!kIsWeb || url.isEmpty) {
    return url;
  }

  final uri = Uri.tryParse(url);
  if (uri == null || uri.host != sourceHost) {
    return url;
  }

  final queryParameters = uri.queryParametersAll.isEmpty ? null : uri.queryParametersAll;
  final proxyUri = Uri.https("proxy.topwr.solvro.pl", "/$proxyPath${uri.path}", queryParameters);

  return proxyUri.toString();
}
