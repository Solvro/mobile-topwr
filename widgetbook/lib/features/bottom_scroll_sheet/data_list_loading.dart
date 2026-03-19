import "package:flutter/widgets.dart";
import "package:topwr/features/bottom_scroll_sheet/data_list_loading.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

@widgetbook.UseCase(name: "default", type: DataListLoading)
Widget useCaseDataListLoading(BuildContext context) {
  return const DataListLoading();
}
