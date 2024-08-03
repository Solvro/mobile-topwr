import "package:collection/collection.dart";
import "package:flutter/widgets.dart";

import "../config/url_icons.dart";

@immutable
class UrlIconsModel {
  final String icon;
  final String? text;
  final String? url;

  UrlIconsModel({
    String? text,
    this.url,
  })  : icon = url.determineIcon(),
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
            IconsConfig.defaultIcon
        : IconsConfig.defaultIcon;
  }
}
