import "package:flutter/material.dart";

import "../config/api_base_config.dart";

extension DirectusAssetsUrlX on String {
  String get directusUrl {
    if (startsWith("https://") || startsWith("http://")) {
      return this; // Already a full URL (not from directus)
    }
    return "${ApiBaseEnv.assetsUrl}/$this";
  }

  String directusUrlWithSize(Size size, BoxFit fit) {
    return "$directusUrl?width=${size.width.toInt()}&height=${size.height.toInt()}&fit=${fit.directusFit}";
  }
}

extension _GetDirectusFitX on BoxFit {
  String get directusFit {
    switch (this) {
      case BoxFit.fill:
        return "cover";
      case BoxFit.contain:
        return "contain";
      case BoxFit.cover:
        return "cover";
      case BoxFit.fitWidth:
        return "inside";
      case BoxFit.fitHeight:
        return "inside";
      case BoxFit.none:
        return "inside";
      case BoxFit.scaleDown:
        return "inside";
    }
  }
}
