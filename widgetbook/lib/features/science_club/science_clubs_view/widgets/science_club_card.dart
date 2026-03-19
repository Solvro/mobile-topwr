import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/material.dart";
import "package:topwr/features/branches/data/model/branch.dart";
import "package:topwr/features/science_club/science_clubs_filters/model/sci_club_type.dart";
import "package:topwr/features/science_club/science_clubs_view/model/science_clubs.dart";
import "package:topwr/features/science_club/science_clubs_view/widgets/science_club_card.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

const _productionScienceClub = ScienceClub(
  id: 1399,
  name: "Koło Naukowe CAD/FEM",
  organizationStatus: ScienceClubStatus.active,
  source: ScienceClubSource.studentDepartment,
  organizationType: ScienceClubType.scientificClub,
  coverPreview: false,
  isStrategic: false,
  branch: Branch.main,
  tags: IList.empty(),
  shortDescription: "Adres e-mail:",
);

@widgetbook.UseCase(name: "default", type: ScienceClubCard)
Widget useCaseScienceClubCard(BuildContext context) {
  return ScienceClubCard(_productionScienceClub, () {});
}
