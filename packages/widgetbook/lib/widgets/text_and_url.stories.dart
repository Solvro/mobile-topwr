import "package:flutter/widgets.dart";
import "package:topwr/widgets/text_and_url_widget.dart";
import "package:widgetbook/widgetbook.dart";

part "text_and_url.stories.g.dart";

const meta = Meta<TextAndUrl>();

final $default = TextAndUrlStory(
  args: TextAndUrlArgs(url: StringArg("https://pwr.edu.pl"), text: StringArg("Read more at")),
);
