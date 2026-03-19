import "package:flutter/widgets.dart";
import "package:topwr/features/my_loc_button/presentation/my_loc_button.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

@widgetbook.UseCase(name: "default", type: MyLocationButton)
Widget useCaseMyLocationButton(BuildContext context) {
  return const MyLocationButton();
}
