import "package:flutter/widgets.dart";
import "package:topwr/widgets/my_html_widget.dart";
import "package:widgetbook/widgetbook.dart";

part "my_html_widget.stories.g.dart";

const meta = Meta(MyHtmlWidget.new);

final $default = MyHtmlWidgetStory(
  args: MyHtmlWidgetArgs(html: StringArg("<p><strong>Widgetbook</strong> preview content with a link.</p>")),
);
