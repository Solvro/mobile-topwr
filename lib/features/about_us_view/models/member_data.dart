import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/foundation.dart";
import "package:freezed_annotation/freezed_annotation.dart";

import "../../../utils/determine_contact_icon.dart";

@immutable
class MemberData {
  final IList<String> socialLinks;
  final String? name;
  final String? subtitle;
  final IList<ContactIconsModel> links;
  final String? directusImageUrl;

  MemberData({
    required this.socialLinks,
    required this.name,
    required this.subtitle,
    required this.directusImageUrl,
  }) : links = _determineLinksIcons(socialLinks);

  static IList<ContactIconsModel> _determineLinksIcons(IList<String> urls) {
    return urls
        .map((url) => ContactIconsModel(url: url))
        .toIList()
        .sort((a, b) => a.order.compareTo(b.order));
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MemberData &&
        other.socialLinks == socialLinks &&
        other.name == name &&
        other.subtitle == subtitle &&
        other.links == links &&
        other.directusImageUrl == directusImageUrl;
  }

  @override
  int get hashCode =>
      socialLinks.hashCode ^
      name.hashCode ^
      subtitle.hashCode ^
      links.hashCode ^
      directusImageUrl.hashCode;
}
