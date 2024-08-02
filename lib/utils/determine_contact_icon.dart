import "package:collection/collection.dart";
import "package:flutter/widgets.dart";

import "../config/contact_icons.dart";

@immutable
class ContactIconsModel {
  final String icon;
  final String? text;
  final String? url;

  ContactIconsModel({
    String? text,
    this.url,
  })  : icon = url.determineIcon(),
        text = text ?? url;
}

extension IconDeterminerX on String? {
  String determineIcon() {
    return this != null
        ? ContactIconsConfig.iconsPaths.entries
                .firstWhereOrNull(
                  (e) => this!.contains(e.key),
                )
                ?.value ??
            ContactIconsConfig.defaultIcon
        : ContactIconsConfig.defaultIcon;
  }
}
