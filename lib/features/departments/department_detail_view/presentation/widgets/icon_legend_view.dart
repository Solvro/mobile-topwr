import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/material.dart";
import "../../../../../utils/context_extensions.dart";
import "icon_view_name.dart";

class IconLegendView extends StatelessWidget {
  const IconLegendView({super.key, required this.iconData});

  final ISet<IconViewName> iconData;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: ElevatedButton(
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
                        item.icon,
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
        child: const Icon(Icons.info_outline),
      ),
    );
  }
}
