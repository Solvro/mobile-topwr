import "package:fast_immutable_collections/fast_immutable_collections.dart";

import "../../../config/contact_icons.dart";
import "../../../utils/determine_contact_icon.dart";

IList<ContactIconsModel> sortContributorsSocialLinks(IList<String> socialLinks) {
  final indexedSocialLinks = <({int index, ContactIconsModel iconModel, int order})>[
    for (var i = 0; i < socialLinks.length; i++)
      (
        index: i,
        iconModel: ContactIconsModel(url: socialLinks[i]),
        order: _contributorsSocialLinkOrder(socialLinks[i]),
      ),
  ];

  indexedSocialLinks.sort((a, b) {
    final orderComparison = a.order.compareTo(b.order);
    if (orderComparison != 0) return orderComparison;
    return a.index.compareTo(b.index);
  });

  return indexedSocialLinks.map((socialLink) => socialLink.iconModel).toIList();
}

int _contributorsSocialLinkOrder(String url) {
  final lowerCaseUrl = url.toLowerCase();

  for (final entry in ContactIconsConfig.contributorsIconsOrder.entries) {
    if (lowerCaseUrl.contains(entry.key)) return entry.value;
  }

  return ContactIconsConfig.defaultContributorsIconOrder;
}
