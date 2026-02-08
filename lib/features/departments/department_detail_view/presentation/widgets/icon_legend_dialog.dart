import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/material.dart";
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
        icon: const Icon(Icons.info_outline, size: 20),
        color: context.colorScheme.tertiary,
        onPressed: () => showDialog<String>(
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
                    Navigator.pop(context);
                  },
                  child: Text(context.localize.close),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
