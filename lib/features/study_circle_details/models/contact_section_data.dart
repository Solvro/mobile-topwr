import 'package:logger/logger.dart';
import '../../../api_base/schema.graphql.dart';
import '../../../config.dart';

class ContactSectionData {
  String iconUrl = DetailsScreenConfig.defaultIconUrl;
  String? text;
  String? url;
  Enum$ENUM_COMPONENTINFOINFO_TYPE? type;

  static const  _icons = {
    "facebook": "assets/icons/ic_fb.png",
    "instagram": "assets/icons/ic_insta.png",
    "linkedin": "assets/icons/ic_linkedin.png",
    "mailto:": "assets/icons/ic_email.png",
  };

  ContactSectionData({
    required this.text,
    required this.url,
    required this.type,
  }) {
    if (url != null) {
      _invalidateUrl();
      _determineIcon();
    }
  }

  void _invalidateUrl() {
    String prefix = switch (type) {
      Enum$ENUM_COMPONENTINFOINFO_TYPE.Email => 'mailto:',
      Enum$ENUM_COMPONENTINFOINFO_TYPE.PhoneNumber => 'tel:',
      Enum$ENUM_COMPONENTINFOINFO_TYPE.Website => 'https://',
      _ => ""
    };
    if (url?.startsWith(prefix) == false) {
      Logger().w("Following url: $url is not properly formatted.");
      url = prefix + url!;
    }
  }

void _determineIcon() {
  iconUrl = _icons.entries.firstWhere((e) => url!.contains(e.key), orElse: () => const MapEntry("", "assets/icons/ic_web.png")).value;
}
}