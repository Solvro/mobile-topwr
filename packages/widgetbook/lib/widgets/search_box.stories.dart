import "package:flutter/widgets.dart";
import "package:topwr/widgets/search_box.dart";
import "package:widgetbook/widgetbook.dart";

part "search_box.stories.g.dart";

const meta = Meta<SearchBox>();

final $default = SearchBoxStory(
  args: SearchBoxArgs(
    onQueryChanged: Arg.fixed((_) {}),
    searchText: NullableStringArg("Search news"),
    initialQuery: NullableStringArg("campus"),
  ),
);
