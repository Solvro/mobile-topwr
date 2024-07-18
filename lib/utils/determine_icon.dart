import 'package:collection/collection.dart';
import 'package:flutter/widgets.dart';

import '../config/url_icons.dart';
import '../widgets/contacs_icons_icons.dart';

@immutable
class UrlIconsModel {
  final IconData icon;
  final String? text;
  final String? url;

  UrlIconsModel({
    String? text,
    this.url,
  })  : icon = url.determineIcon(),
        text = text ?? url;
}

extension IconDeterminer on String? {
  IconData determineIcon() {
    return this != null
        ? IconsConfig.iconsPaths.entries
                .firstWhereOrNull(
                  (e) => this!.contains(e.key),
                )
                ?.value ??
            ContactsIcons.web
        : ContactsIcons.web;
  }
}
