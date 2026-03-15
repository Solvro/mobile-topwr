import "package:flutter/material.dart";
import "package:solvro_translator_core/solvro_translator_core.dart";

import "../../../../utils/context_extensions.dart";
import "../model/science_club_details.dart";

extension ScienceClubDetailsLocalization on ScienceClubDetails {
  String localizedName(BuildContext context) {
    return context.solvroLocale == SolvroLocale.pl ? name : enName ?? name;
  }

  String localizedDescription(BuildContext context) {
    return context.solvroLocale == SolvroLocale.pl ? description ?? "" : enDescription ?? description ?? "";
  }
}
