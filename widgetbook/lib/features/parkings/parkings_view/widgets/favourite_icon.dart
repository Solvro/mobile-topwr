import "package:flutter/material.dart";
import "package:topwr/features/parkings/parkings_view/widgets/parking_favourite.dart";
import "package:widgetbook/widgetbook.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

@widgetbook.UseCase(name: "default", type: FavouriteIcon)
Widget useCaseFavouriteIcon(BuildContext context) {
  return FavouriteIcon(
    icon: Icons.favorite,
    color: context.knobs.object.dropdown(label: "Color", options: [Colors.red, Colors.blue, Colors.green, Colors.grey]),
  );
}
