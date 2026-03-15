import "package:flutter/material.dart";
import "package:solvro_translator_core/solvro_translator_core.dart";

import "../../../../utils/context_extensions.dart";
import "../model/science_clubs.dart";

extension ScienceClubLocalization on ScienceClub {
  String localizedName(BuildContext context) {
    return context.solvroLocale == SolvroLocale.pl ? name : enName ?? name;
  }

  String localizedShortDescription(BuildContext context) {
    return context.solvroLocale == SolvroLocale.pl
        ? shortDescription ?? ""
        : enShortDescription ?? shortDescription ?? "";
  }
}
