import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/material.dart";

import "../../../../../config/env.dart";
import "../../../../../theme/app_theme.dart";
import "../../../../../theme/hex_color.dart";
import "../../../../../utils/colors_sort.dart";
import "../../../../../utils/context_extensions.dart";
import "../../presentation/widgets/icon_view_name.dart";
import "../models/department_details.dart";
import "../models/studies_type.dart";

extension DetailedDepartmentsX on DepartmentDetails {
  LinearGradient get gradient =>
      LinearGradient(colors: [HexColor(gradientStart), HexColor(gradientStop)]..sortByLightness());

  String get imageUrl => "${Env.mainRestApiUrl.substring(0, Env.mainRestApiUrl.length - 7)}/uploads/$logoKey.png";

  String get address3lines {
    const separateAddressPattern = r"^(.*)\s((ul\.|wyb\.|pl\.).*)";
    final match = RegExp(separateAddressPattern).firstMatch(addressLine1);
    return match != null ? "${match.group(1)}\n${match.group(2)}\n$addressLine2" : "$addressLine1\n$addressLine2";
  }
}

extension WhereTypesX on IList<FieldOfStudy> {
  Iterable<FieldOfStudy> get whereFirstDegree {
    return where((item) => !item.studiesType.isSecondDegree && !item.studiesType.isLongCycle);
  }

  Iterable<FieldOfStudy> get whereSecondDegree {
    return where((item) => item.studiesType.isSecondDegree && !item.studiesType.isLongCycle);
  }

  Iterable<FieldOfStudy> get whereLongCycle {
    return where((item) => item.studiesType.isLongCycle);
  }
}

extension FieldOfStudyIconSetExtension on Iterable<FieldOfStudy> {
  ISet<IconViewName> toIconSet(BuildContext context) {
    const fontSize = 14.0;
    final emojiStyle = context.textTheme.headlineMedium?.copyWith(fontSize: fontSize);

    return {
      IconViewName(
        name: context.localize.iconnames_sunny,
        icon: Icon(Icons.sunny, color: context.colorScheme.tertiary, size: fontSize),
      ),
      for (final degree in this) ...{
        if (degree.isEnglish)
          IconViewName(
            name: context.localize.iconnames_english_language,
            icon: Text("🇬🇧", style: emojiStyle),
          )
        else
          IconViewName(
            name: context.localize.iconnames_polish_language,
            icon: Text("🇵🇱", style: emojiStyle),
          ),

        if (degree.hasWeekendOption)
          IconViewName(
            name: context.localize.iconnames_has_weekend_option,
            icon: Icon(Icons.remove_red_eye_outlined, color: context.colorScheme.tertiary, size: fontSize),
          ),
      },
    }.toISet();
  }
}
