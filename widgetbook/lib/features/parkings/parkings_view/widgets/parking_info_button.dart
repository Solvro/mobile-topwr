import "package:flutter/widgets.dart";
import "package:topwr/features/parkings/parkings_view/widgets/parking_info_button.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

@widgetbook.UseCase(name: "default", type: ParkingInfoButton)
Widget useCaseParkingInfoButton(BuildContext context) {
  return const ParkingInfoButton();
}
