import 'package:collection/collection.dart';

import '../../../../../config/ui_config.dart';

class LinkData {
  String iconUrl;
  String? url;

  static const _icons = {
    "facebook": "assets/icons/ic_fb.png",
    "instagram": "assets/icons/ic_insta.png",
    "linkedin": "assets/icons/ic_linkedin.png",
    "github": "assets/icons/ic_github.png",
    "mailto:": "assets/icons/ic_email.png",
    "pwr.edu.pl": "assets/icons/ic_web.png",
  };

  LinkData({
    required this.url,
  }) : iconUrl = _determineIcon(url);

  static String _determineIcon(String? url) {
    return url != null
        ? _icons.entries
                .firstWhereOrNull(
                  (e) => url.contains(e.key),
                )
                ?.value ??
            DetailsScreenConfig.defaultIconUrl
        : DetailsScreenConfig.defaultIconUrl;
  }
}
