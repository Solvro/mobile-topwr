import "package:flutter/widgets.dart";
import "package:topwr/features/parkings/parkings_view/widgets/offline_parkings_view.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

@widgetbook.UseCase(name: "default", type: OfflineParkingsView)
Widget useCaseOfflineParkingsView(BuildContext context) {
  return const OfflineParkingsView();
}
