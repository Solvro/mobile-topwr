import "package:flutter/widgets.dart";
import "package:topwr/features/departments/department_detail_view/presentation/department_detail_view.dart";
import "package:widgetbook/widgetbook.dart";

part "department_detail_view.stories.g.dart";

const meta = Meta<DepartmentDetailView>();

final $default = DepartmentDetailViewStory(
  name: "Production view with hardcoded data",
  args: DepartmentDetailViewArgs.fixed(id: 5),
);
