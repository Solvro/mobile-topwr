import "package:flutter/widgets.dart";
import "package:topwr/widgets/detail_views/contact_icon_widget.dart";
import "package:widgetbook/widgetbook.dart";

part "contact_icon_widget.stories.g.dart";

const meta = Meta<ContactIconWidget>();

const _defaultContactSvg = "packages/topwr_assets/assets/svg/contact_icons/mail.svg";

final $default = ContactIconWidgetStory(args: ContactIconWidgetArgs(icon: StringArg(_defaultContactSvg)));
