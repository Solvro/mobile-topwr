import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/widgets.dart";
import "package:topwr/api_base_rest/shared_models/image_data.dart";
import "package:topwr/api_base_rest/shared_models/social_links_data.dart";
import "package:topwr/features/branches/data/model/branch.dart";
import "package:topwr/features/departments/department_detail_view/data/models/department_details.dart";
import "package:topwr/features/departments/department_detail_view/data/models/studies_type.dart";
import "package:topwr/features/departments/department_detail_view/presentation/widgets/science_clubs_section.dart";
import "package:topwr/features/science_club/science_clubs_view/model/science_clubs.dart";
import "package:widgetbook/widgetbook.dart";
import "../../../../../widgetbook_placeholders.dart";

part "department_science_clubs_section.stories.g.dart";

final _mockDepartment = DepartmentDetails(
  id: 1,
  name: "Wydział Informatyki i Telekomunikacji",
  code: "W4",
  betterCode: "WIT",
  logo: const ImageData(url: widgetbookPlaceholderImageUrl),
  gradientStart: "#FF5733",
  gradientStop: "#33FF57",
  addressLine1: "ul. Janiszewskiego 11/17",
  addressLine2: "50-372 Wrocław",
  branch: Branch.main,
  fieldsOfStudy: IList(const [
    FieldOfStudy(
      name: "Informatyka stosowana",
      url: "https://wit.pwr.edu.pl/kandydaci/studia-i-stopnia/informatyka-stosowana",
      isEnglish: false,
      studiesType: StudiesType.firstDegree,
      hasWeekendOption: false,
    ),
    FieldOfStudy(
      name: "Applied Computer Science",
      url: "https://wit.pwr.edu.pl/en/candidates/studies-in-english/applied-computer-science",
      isEnglish: true,
      studiesType: StudiesType.secondDegree,
      hasWeekendOption: true,
    ),
  ]),
  departmentLinks: IList(const [
    SocialLinksData(url: "https://wit.pwr.edu.pl", name: "Strona wydziału"),
    SocialLinksData(url: "https://www.facebook.com/WIT.PWr", name: "Facebook"),
  ]),
);

const meta = Meta<DepartmentScienceClubsSection>();

final $default = DepartmentScienceClubsSectionStory(
  args: DepartmentScienceClubsSectionArgs(
    departmentWithSciClubs: Arg.fixed((department: _mockDepartment, sciclubs: IList<ScienceClub>(const []))),
  ),
);
