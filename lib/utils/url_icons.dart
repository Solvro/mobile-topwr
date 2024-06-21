import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import '../config/ui_config.dart';
import '../config/url_icons.dart';

@immutable
class UrlIconsUtilModel {
  final String iconUrl;
  final String? text;
  final String? url;

  UrlIconsUtilModel({
    String? text,
    this.url,
  })  : iconUrl = _determineIcon(url),
        text = text ?? url;

  static String _determineIcon(String? url) {
    return url != null
        ? UrlIconsConfig.icons.entries
                .firstWhereOrNull(
                  (e) => url.contains(e.key),
                )
                ?.value ??
            DetailsScreenConfig.defaultIconUrl
        : DetailsScreenConfig.defaultIconUrl;
  }
}