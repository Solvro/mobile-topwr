import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';

import '../config/url_icons.dart';
import '../gen/assets.gen.dart';

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
  static final _defaultIconUrl = Assets.icons.icWeb.path;

  String determineIcon() {
    return this != null
        ? IconsConfig.iconsPaths.entries
                .firstWhereOrNull(
                  (e) => this!.contains(e.key),
                )
                ?.value ??
            _defaultIconUrl
        : _defaultIconUrl;
  }
}
