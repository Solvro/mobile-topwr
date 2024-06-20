import 'package:collection/collection.dart';
import '../config/ui_config.dart';

extension IconDeterminer on String? {
  String determineIcon() {
    return this != null
        ? IconsConfig.iconsPaths.entries
                .firstWhereOrNull(
                  (e) => this!.contains(e.key),
                )
                ?.value ??
            DetailsScreenConfig.defaultIconUrl
        : DetailsScreenConfig.defaultIconUrl;
  }
}
