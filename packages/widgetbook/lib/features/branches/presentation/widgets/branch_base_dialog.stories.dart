import "package:topwr/features/branches/data/model/branch.dart";
import "package:topwr/features/branches/presentation/widgets/branch_base_dialog.dart";
import "package:widgetbook/widgetbook.dart";

part "branch_base_dialog.stories.g.dart";

class BranchBaseDialogStoryKnobs {
  final String title;
  final Branch? selectedBranch;
  final bool centerTitle;
  final bool showApplyButton;
  final String? applyButtonText;
  BranchBaseDialogStoryKnobs({
    required this.title,
    this.selectedBranch,
    required this.centerTitle,
    required this.showApplyButton,
    this.applyButtonText,
  });
}

const meta = Meta(BranchBaseDialog.new, argsType: BranchBaseDialogStoryKnobs.new);

final defaults = _Defaults(
  builder: (context, args) => BranchBaseDialog(
    title: args.title,
    selectedBranch: args.selectedBranch,
    onBranchTap: (_) {},
    centerTitle: args.centerTitle,
    showApplyButton: args.showApplyButton,
    applyButtonText: args.applyButtonText,
    onApplyButtonPressed: () {},
  ),
);

final $default = BranchBaseDialogStory(
  args: BranchBaseDialogStoryKnobsArgs(
    title: StringArg("Choose branch"),
    selectedBranch: Arg.fixed(Branch.main),
    centerTitle: BoolArg(true),
    showApplyButton: BoolArg(true),
    applyButtonText: NullableStringArg("Apply"),
  ),
);
