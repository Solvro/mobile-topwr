import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';

import '../config/ui_config.dart';
import '../config/url_icons.dart';

@immutable
class UrlIconsModel {
  final String iconUrl;
  final String? text;
  final String? url;

  UrlIconsModel({
    String? text,
    this.url,
  })  : iconUrl = url.determineIcon(),
        text = text ?? url;
}

extension IconDeterminer on String? {
  String determineIcon() {
    return this != null
        ? IconsConfig.iconsPaths.entries
                .firstWhereOrNull(
                  (e) => this!.contains(e.key),
                )
                ?.value ??
            DetailsScreenConfig.defaultIconUrl
        : DetailsScreenConfig.defaultIconUrl;
  }
}
