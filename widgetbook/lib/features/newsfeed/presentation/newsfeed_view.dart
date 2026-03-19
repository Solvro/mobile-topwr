import "package:flutter/widgets.dart";
import "package:topwr/features/newsfeed/presentation/news_list_view.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

@widgetbook.UseCase(name: "default", type: NewsfeedView)
Widget useCaseNewsfeedView(BuildContext context) {
  return const NewsfeedView();
}
