import 'package:logger/logger.dart';
import 'package:url_launcher/url_launcher.dart';

import '../repository/map_buildings_repo.dart';

class GoogleMapsLinkUtils {
  static Future<void> navigateTo(Building building) async {
    final uri = Uri.parse(
        "google.navigation:q=${building.latitude},${building.longitude}&mode=d");
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      Logger().e('Could not launch ${uri.toString()}');
    }
  }
}
