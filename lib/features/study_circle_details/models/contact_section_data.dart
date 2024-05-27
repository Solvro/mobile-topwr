import 'package:collection/collection.dart';

import '../../../config.dart';

class ContactSectionData {
  String iconUrl;
  String? text;
  String? url;

  static const _icons = {
    "facebook": "assets/icons/ic_fb.png",
    "instagram": "assets/icons/ic_insta.png",
    "linkedin": "assets/icons/ic_linkedin.png",
    "mailto:": "assets/icons/ic_email.png",
  };

  ContactSectionData({
    required this.text,
    required this.url,
  }) : iconUrl = _determineIcon(url);

  static String _determineIcon(String? url) {
    if (url == null) return DetailsScreenConfig.defaultIconUrl;
    return _icons.entries.firstWhereOrNull((e) => url.contains(e.key))?.value ??
        DetailsScreenConfig.defaultIconUrl;
  }
}
