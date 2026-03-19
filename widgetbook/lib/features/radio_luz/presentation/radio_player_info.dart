import "package:flutter/widgets.dart";
import "package:topwr/features/radio_luz/presentation/radio_player_info.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

@widgetbook.UseCase(name: "default", type: RadioPlayerInfo)
Widget useCaseRadioPlayerInfo(BuildContext context) {
  return const RadioPlayerInfo();
}
