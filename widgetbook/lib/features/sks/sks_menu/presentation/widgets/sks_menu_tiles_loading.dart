import "package:flutter/widgets.dart";
import "package:topwr/features/sks/sks_menu/presentation/widgets/sks_menu_view_loading.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

@widgetbook.UseCase(name: "default", type: SksMenuTilesLoading)
Widget useCaseSksMenuTilesLoading(BuildContext context) {
  return const SksMenuTilesLoading();
}
