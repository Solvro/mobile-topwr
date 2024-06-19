import '../../../utils/determine_icon.dart';

class ContactSectionData {
  String iconUrl;
  String? text;
  String? url;

  ContactSectionData({
    required this.text,
    required this.url,
  }) : iconUrl = url.determineIcon();
}
