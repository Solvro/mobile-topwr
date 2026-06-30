import "package:flutter/widgets.dart";
import "package:topwr/features/radio_luz/presentation/search_streaming_bottom_sheet.dart";
import "package:widgetbook/widgetbook.dart";

part "search_streaming_bottom_sheet.stories.g.dart";

const meta = Meta(SearchStreamingBottomSheet.new);

final $default = SearchStreamingBottomSheetStory(
  args: SearchStreamingBottomSheetArgs(title: StringArg("Wroclaw Sunset"), artist: StringArg("DJ Solvro")),
);
