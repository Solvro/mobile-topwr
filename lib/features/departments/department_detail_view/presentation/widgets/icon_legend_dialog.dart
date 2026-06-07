import "dart:async";

import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "../../../../../theme/app_theme.dart";
import "../../../../../utils/context_extensions.dart";
import "icon_view_name.dart";

class IconLegendDialog extends StatelessWidget {
  const IconLegendDialog({super.key, required this.iconData});

  final ISet<IconViewName> iconData;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: IconButton(
        tooltip: context.localize.iconnames_legend_title,
        icon: const Icon(Icons.info_outline, semanticLabel: "", size: 20),
        color: context.colorScheme.tertiary,
        onPressed: () async {
          unawaited(HapticFeedback.selectionClick());
          await showDialog<String>(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: Text(context.localize.iconnames_legend_title),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ...iconData.map(
                    (item) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      child: Row(
                        children: [
                          SizedBox.square(
                            dimension: 20,
                            child: Align(alignment: Alignment.centerLeft, child: item.icon),
                          ),
                          const SizedBox(width: 12),
                          Expanded(child: Text(item.name)),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  TextButton(
                    onPressed: () {
                      unawaited(HapticFeedback.selectionClick());
                      Navigator.pop(context);
                    },
                    child: Text(context.localize.close),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
