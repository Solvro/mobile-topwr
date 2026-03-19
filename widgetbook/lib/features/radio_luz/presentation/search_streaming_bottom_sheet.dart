import "package:flutter/widgets.dart";
import "package:topwr/features/radio_luz/presentation/search_streaming_bottom_sheet.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

@widgetbook.UseCase(name: "default", type: SearchStreamingBottomSheet)
Widget useCaseSearchStreamingBottomSheet(BuildContext context) {
  return const SearchStreamingBottomSheet(title: "Sample Title", artist: "Sample Artist");
}
