import "package:flutter/widgets.dart";
import "package:topwr/features/my_loc_button/presentation/my_loc_layer.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

@widgetbook.UseCase(name: "default", type: MyLocationLayer)
Widget useCaseMyLocationLayer(BuildContext context) {
  return const MyLocationLayer();
}
