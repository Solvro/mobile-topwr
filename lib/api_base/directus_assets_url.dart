import "../config/api_base_config.dart";

extension DirectusAssetsUrlX on String {
  String get directusUrl {
    return "${ApiBaseEnv.assetsUrl}/$this";
  }
}

extension DirectusAssetsUrlNullableX on String? {
  String get directusUrl {
    return this?.directusUrl ?? "";
  }
}
