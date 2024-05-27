import 'config.dart';

extension DirectusAssetsUrl on String {
  String get directusUrl {
    return "${ApiBaseEnv.assetsUrl}/$this";
  }
}

extension DirectusAssetsUrlNullable on String? {
  String get directusUrl {
    return this?.directusUrl ?? "";
  }
}
