import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/material.dart";
import "../utils/context_extensions.dart";
import "../utils/icon_view_name.dart";

class IconLegendView extends StatelessWidget {
  const IconLegendView({super.key, required this.iconData});

  final ISet<IconViewName> iconData;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: OutlinedButton(
        onPressed: () => showDialog<String>(
          context: context,
          builder: (BuildContext context) => Dialog(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
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
        ),
        child: Text(context.localize.iconnames_legend),
      ),
    );
  }
}
