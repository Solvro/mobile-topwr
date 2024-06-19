import 'package:collection/collection.dart';

import '../config/ui_config.dart';

extension IconDeterminer on String? {
  String determineIcon() {
    const icons = {
      "facebook": "assets/icons/ic_fb.png",
      "instagram": "assets/icons/ic_insta.png",
      "linkedin": "assets/icons/ic_linkedin.png",
      "mailto:": "assets/icons/ic_email.png",
      "youtu": "assets/icons/ic_youtube.png",
      "github": "assets/icons/ic_github.png",
    };

    return this != null
        ? icons.entries
                .firstWhereOrNull(
                  (e) => this!.contains(e.key),
                )
                ?.value ??
            DetailsScreenConfig.defaultIconUrl
        : DetailsScreenConfig.defaultIconUrl;
  }
}
