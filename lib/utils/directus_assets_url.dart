import '../api_base/config.dart';

extension DirectusAssetsUrl on String {
  String get directusUrl {
    return "${ApiBaseEnv.apiUrl}/assets/$this";
  }
}

extension DirectusAssetsUrlNullable on String? {
  String get directusUrl {
    return this?.directusUrl ?? "";
  }
}
