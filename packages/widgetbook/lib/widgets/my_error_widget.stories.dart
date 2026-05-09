import "package:flutter/widgets.dart";
import "package:topwr/widgets/my_error_widget.dart";
import "package:widgetbook/widgetbook.dart";

part "my_error_widget.stories.g.dart";

const meta = Meta<MyErrorWidget>();

final $default = MyErrorWidgetStory(args: MyErrorWidgetArgs(error: Arg.fixed("Example error message")));
