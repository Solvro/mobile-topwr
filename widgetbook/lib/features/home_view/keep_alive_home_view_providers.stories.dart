import "package:flutter/widgets.dart";
import "package:topwr/features/home_view/keep_alive_home_view_providers.dart";
import "package:widgetbook/widgetbook.dart";

part "keep_alive_home_view_providers.stories.g.dart";

const meta = Meta<KeepAliveHomeViewProviders>();

final $default = KeepAliveHomeViewProvidersStory(
  args: KeepAliveHomeViewProvidersArgs(child: Arg.fixed(const SizedBox.shrink())),
);
