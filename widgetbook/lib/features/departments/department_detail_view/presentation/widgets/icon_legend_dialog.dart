import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/material.dart";
import "package:topwr/features/departments/department_detail_view/presentation/widgets/icon_legend_dialog.dart";
import "package:topwr/features/departments/department_detail_view/presentation/widgets/icon_view_name.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

final _mockIconData = ISet<IconViewName>({
  const IconViewName(name: "English", icon: Icon(Icons.language)),
  const IconViewName(name: "Weekend", icon: Icon(Icons.calendar_today)),
});

@widgetbook.UseCase(name: "default", type: IconLegendDialog)
Widget useCaseIconLegendDialog(BuildContext context) {
  return IconLegendDialog(iconData: _mockIconData);
}
