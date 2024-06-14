import 'link_data.dart';

class MemberData {
  List<String> socialLinks;
  String? name;
  String? subtitle;
  List<LinkData> links;
  String? imageUrl;

  MemberData({
    required this.socialLinks,
    required this.name,
    required this.subtitle,
    required this.imageUrl,
  }) : links = _determineLinksIcons(socialLinks);

  static List<LinkData> _determineLinksIcons(List<String> urls) {
    return urls.map((url) => LinkData(url: url)).toList();
  } 
}
