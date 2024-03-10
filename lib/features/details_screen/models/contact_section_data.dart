import 'package:logger/logger.dart';
import '../../../api_base/schema.graphql.dart';

class ContactSectionData {
  String? iconUrl;
  String? text;
  String? url;
  Enum$ENUM_COMPONENTINFOINFO_TYPE? type;

  ContactSectionData({
    required this.iconUrl,
    required this.text,
    required this.url,
    required this.type,
  }) {
    if (url != null) {
      _invalidateUrl();
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
}