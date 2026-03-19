import "package:flutter/material.dart";
import "package:topwr/widgets/arrow_button.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

@widgetbook.UseCase(name: "default", type: ArrowButton)
Widget useCaseArrowButton(BuildContext context) {
  return ArrowButton(icon: Icons.info, onPressed: () {});
}
