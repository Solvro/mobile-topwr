import "package:collection/collection.dart";
import "package:freezed_annotation/freezed_annotation.dart";

import "../../../../l10n/app_localizations.dart";

@JsonEnum(fieldRename: FieldRename.snake)
enum Branch {
  main,
  walbrzych,
  legnica,
  jeleniaGora;

  String localize(AppLocalizations localize) => switch (this) {
    Branch.main => localize.main_branch,
    Branch.jeleniaGora => localize.jelenia_gora_branch,
    Branch.walbrzych => localize.walbrzych_branch,
    Branch.legnica => localize.legnica_branch,
  };

  String localizeFilter(AppLocalizations localize) => switch (this) {
    Branch.main => localize.main_branch_filter,
    Branch.jeleniaGora => localize.jelenia_gora_branch_filter,
    Branch.walbrzych => localize.walbrzych_branch_filter,
    Branch.legnica => localize.legnica_branch_filter,
  };

  static Branch? fromNameOrNull(String? value) {
    return Branch.values.firstWhereOrNull((branch) => branch.name == value);
  }

  factory Branch.fromName(String value) {
    return Branch.values.firstWhere((branch) => branch.name == value);
  }
}
