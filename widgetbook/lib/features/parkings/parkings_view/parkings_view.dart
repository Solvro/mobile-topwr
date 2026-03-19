import "package:flutter/widgets.dart";
import "package:topwr/features/parkings/parkings_view/parkings_view.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

@widgetbook.UseCase(name: "default", type: ParkingsView)
Widget useCaseParkingsView(BuildContext context) {
  return const ParkingsView();
}
