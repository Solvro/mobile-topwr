import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../science_club/science_clubs_view/model/science_clubs.dart";
import "../../../science_club/science_clubs_view/repository/science_clubs_repository.dart";
import "../data/models/department_details.dart";
import "../data/repository/department_details_repository.dart";

part "department_detail_service.g.dart";

typedef DepartmentWithSciClubs = ({DepartmentDetails department, IList<ScienceClub> sciclubs});

@riverpod
Future<DepartmentWithSciClubs> departmentDetailService(Ref ref, int id) async {
  final department = await ref.watch(departmentDetailsRepositoryProvider(id).future);
  final scienceClubs = await ref.watch(scienceClubsRepositoryProvider.future);
  final filtered = scienceClubs.where((sciClub) => sciClub.department?.id == department.id).toIList();

  return (department: department, sciclubs: filtered);
}
