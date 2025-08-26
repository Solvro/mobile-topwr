import "package:flutter/material.dart";
import "package:flutter_map/flutter_map.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../config/map_view_config.dart";
import "../../../utils/launch_url_util.dart";

/// legal requirements for using OpenStreetMap
class OpenMapAtrribution extends ConsumerWidget {
  const OpenMapAtrribution({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return RichAttributionWidget(
      attributions: [
        TextSourceAttribution(OpenStreetMapConfig.attribution, onTap: () => ref.launch(OpenStreetMapConfig.copyright)),
      ],
    );
  }
}
