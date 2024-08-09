import "package:collection/collection.dart";
import "package:flutter/widgets.dart";

import "../config/contact_icons.dart";

@immutable
class ContactIconsModel {
  final String icon;
  final String? text;
  final String? url;
  final int order;

  ContactIconsModel({
    String? text,
    this.url,
  })  : icon = url.determineIcon(),
        order = url.determineIconOrder(),
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
  int determineIconOrder() {
    return this != null
        ? ContactIconsConfig.iconsOrder.entries
                .firstWhereOrNull(
                  (e) => this!.contains(e.key),
                )
                ?.value ??
            ContactIconsConfig.defaultIconOrder
        : ContactIconsConfig.defaultIconOrder;
  }
}
