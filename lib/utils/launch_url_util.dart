import 'package:url_launcher/url_launcher.dart';

class LaunchUrlUtil {
  static Future<bool> launch(String uriStr) async {
    final uri = Uri.parse(uriStr);
    if (await canLaunchUrl(uri)) {
      return await launchUrl(uri);
    }
    return false;
  }
}
