import "package:topwr/features/branches/data/model/branch.dart";
import "package:topwr/features/branches/presentation/widgets/branch_list.dart";
import "package:widgetbook/widgetbook.dart";

part "branch_list.stories.g.dart";

class BranchListStoryKnobs {
  final Branch? selectedBranch;
  BranchListStoryKnobs({this.selectedBranch});
}

const meta = MetaWithArgs<BranchList, BranchListStoryKnobs>();

final defaults = _Defaults(
  builder: (context, args) => BranchList(selectedBranch: args.selectedBranch, onBranchTap: (_) {}),
);

final $default = BranchListStory();
