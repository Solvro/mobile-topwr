import "package:flutter/material.dart";
import "package:topwr/features/home_view/widgets/web_version_prompt.dart";
import "package:widgetbook/widgetbook.dart";

part "web_version_prompt.stories.g.dart";

const meta = Meta<WebVersionDialogContent>(name: "WebVersionDialogContent");

final $default = WebVersionDialogContentStory(
  args: WebVersionDialogContentArgs.fixed(),
  builder: (context, args) => WebVersionDialogContent(key: args.key),
);
