import "package:flutter/widgets.dart";
import "package:topwr/features/sks/sks_favourite_dishes/presentation/sks_favourite_dishes_view.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

@widgetbook.UseCase(name: "default", type: SksFavouriteDishesView)
Widget useCaseSksFavouriteDishesView(BuildContext context) {
  return const SksFavouriteDishesView();
}
