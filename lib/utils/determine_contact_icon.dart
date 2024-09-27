import "package:collection/collection.dart";
import "package:flutter/widgets.dart";

import "../config/contact_icons.dart";

@immutable
class ContactIconsModel {
  final String icon;
  final String? text;
  final String? url;
  final int order;
  final bool isSciClub;

  ContactIconsModel({
    String? text,
    this.url,
    this.isSciClub = true,
  })  : icon = url.determineIcon(),
        order = isSciClub
            ? url.determineIconOrderForSciClubs()
            : url.determineIconOrderForAboutUs(),
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

  int determineIconOrderForSciClubs() {
    return this != null
        ? ContactIconsConfig.iconsOrderAtSciClubs.entries
                .firstWhereOrNull(
                  (e) => this!.contains(e.key),
                )
                ?.value ??
            ContactIconsConfig.defaultIconOrderAtSciClubs
        : ContactIconsConfig.defaultIconOrderAtSciClubs;
  }

  int determineIconOrderForAboutUs() {
    return this != null
        ? ContactIconsConfig.iconsOrderAtAboutUs.entries
                .firstWhereOrNull(
                  (e) => this!.contains(e.key),
                )
                ?.value ??
            ContactIconsConfig.defaultIconOrderAtAboutUs
        : ContactIconsConfig.defaultIconOrderAtAboutUs;
  }
}
