import "package:flutter/widgets.dart";
import "package:topwr/widgets/general_offline_message.dart";
import "package:widgetbook/widgetbook.dart";

part "offline_message.stories.g.dart";

const meta = Meta<OfflineMessage>();

final $default = OfflineMessageStory(
  args: OfflineMessageArgs(
    errMessage: StringArg("You are offline. Check your connection and try again."),
    onRefresh: Arg.fixed(() {}),
  ),
);
