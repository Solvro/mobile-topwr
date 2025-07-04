import "package:json_annotation/json_annotation.dart";

part "umami_events.g.dart";

@JsonEnum(alwaysCreate: true, fieldRename: FieldRename.snake)
enum UmamiEvents {
  openGuideArticleDetail,
  openScienceClubDetail,
  openDepartmentDetail,
  openSksMenu,
  openSksChart,
  openSettings,
  openAboutUs,
  openAboutTheApp,
  openFeedbackForm,
  openLeaveReview,
  openDepartmentsList,
  openSciClubsList,
  openParkingChart,
  openSciClubFromDepartmentDetailView,
  openDigitalGuideDetail,
  changeLanguage,
  setAccessibilityMode,
  saveAccessibilityModeDialog,
  closeAccessibilityModeDialog,
  openAccessibilityModeDialog,
  openDaySwapAlertDialog,
  openBannerDialog,
  goToBannerExternalLink,
  goToExternalLink,
  selectBuilding,
  searchBuilding,
  selectSciClubFilterTag,
  selectSciClubFilterDepartment,
  selectSciClubFilterOrgType,
  searchSciClubFilters,
  searchSciClub,
  openTeamMemberLink,
  openSolvroAboutUsLink,
  openExternalAccessibilityDeclarationWebsite,
  searchParkings,
  searchGuideArticles,
  openFAQQuestion,
  closeFAQQuestion,
  openNotificationInfoBellDialog,
  searchDepartments,
  openFieldOfStudiesLink,
  openSciClubsFilterSheet,
  clearSciClubFilters,
  seeOldSksMenu,
  openAcademicCalendarExternalLink,
  openSolvroScienceClubDetailPage,
  openDigitalGuideSubscreen;

  String toJson() => _$UmamiEventsEnumMap[this]!;
}
