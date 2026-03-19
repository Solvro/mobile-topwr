import "package:flutter/widgets.dart";
import "package:topwr/features/sks/sks_favourite_dishes/presentation/widgets/sks_favourite_dishes_loading.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

@widgetbook.UseCase(name: "default", type: SksFavouriteDishesViewLoading)
Widget useCaseSksFavouriteDishesViewLoading(BuildContext context) {
  return const SksFavouriteDishesViewLoading();
}
