import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/material.dart";
import "package:topwr/features/departments/department_detail_view/presentation/widgets/icon_legend_dialog.dart";
import "package:topwr/features/departments/department_detail_view/presentation/widgets/icon_view_name.dart";
import "package:widgetbook/widgetbook.dart";

part "icon_legend_dialog.stories.g.dart";

final _mockIconData = ISet<IconViewName>({
  const IconViewName(name: "English", icon: Icon(Icons.language)),
  const IconViewName(name: "Weekend", icon: Icon(Icons.calendar_today)),
});

const meta = Meta(IconLegendDialog.new);

final $default = IconLegendDialogStory(args: IconLegendDialogArgs(iconData: Arg.fixed(_mockIconData)));
