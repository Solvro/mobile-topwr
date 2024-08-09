import "package:collection/collection.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:url_launcher/url_launcher.dart";

import "../features/buildings_view/repository/buildings_repository.dart";
import "../features/navigator/utils/navigation_commands.dart";
import "../utils/where_non_null_iterable.dart";

extension LaunchUrlUtilX on WidgetRef? {
  Future<bool> launch(String uriStr) async {
    if (this != null && uriStr.startsWith("topwr:")) {
      return this!._launchTopwrLink(uriStr);
    }
    final uri = Uri.parse(uriStr);
    if (await canLaunchUrl(uri)) {
      return launchUrl(uri);
    }
    return false;
  }
}

extension _LaunchTopwrRouteX on WidgetRef {
  // TODO(simon-the-shark): implement proper applinks or deeplinks
  Future<bool> _launchTopwrLink(String uriStr) async {
    if (uriStr.startsWith("topwr:buildings/")) {
      final id = uriStr.replaceFirst("topwr:buildings/", "");
      final buildings = await read(buildingsRepositoryProvider.future);
      final building =
          buildings.whereNonNull.firstWhereOrNull((i) => i.id == id);
      if (building == null) return false;
      await navigateBuilding(building);
      return true;
    }
    return false;
  }
}
