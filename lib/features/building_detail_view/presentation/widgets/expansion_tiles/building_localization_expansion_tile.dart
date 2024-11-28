import "package:flutter/widgets.dart";
import "../../../../../widgets/my_expansion_tile.dart";

class BuildingExpansionTile extends StatelessWidget {
  const BuildingExpansionTile({
    required this.title
  });

  final String title;
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: MyExpansionTile(
        title: title, 
        children: [
          const Text("Tile"),
        ]
      )
    );
  }
  
}