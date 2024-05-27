import '../repository/academ_calnd_data_repo.dart';
import '../utils/find_monday.dart';

extension AcademicCalendarExtraAttrs on AcademicCalendar {
  DateTime get now => DateTime.now();

  bool isHolidays() {
    return now.isBefore(semesterStartDate) || now.isAfter(examSessionLastDay);
  }

  bool isExamSession() {
    return now.isAfter(examSessionStartDate) &&
        now.isBefore(examSessionLastDay);
  }

  bool isSemester() {
    return now.isAfter(semesterStartDate) && now.isBefore(examSessionStartDate);
  }

  bool shouldBeEvenWeek() {
    final zeroMonday = semesterStartDate.findMondayOfTheWeek();
    final numWeeksFromZeroMonday = zeroMonday.calculateWeeksTo(now);
    if (numWeeksFromZeroMonday.isEven) {
      return isFirstWeekEven;
    }
    return !isFirstWeekEven;
  }
}
