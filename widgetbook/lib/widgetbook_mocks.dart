import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:topwr/api_base_rest/shared_models/image_data.dart";
import "package:topwr/api_base_rest/shared_models/social_links_data.dart";
import "package:topwr/features/academic_calendar/model/academic_calendar.dart";
import "package:topwr/features/academic_calendar/model/day_swap_model.dart";
import "package:topwr/features/academic_calendar/model/weekday_enum.dart";
import "package:topwr/features/academic_calendar/repository/academic_calendar_repo.dart";
import "package:topwr/features/app_changelog/data/models/changelog.dart";
import "package:topwr/features/branches/data/model/branch.dart";
import "package:topwr/features/calendar/bussiness/models.dart";
import "package:topwr/features/departments/department_detail_view/data/models/department_details.dart";
import "package:topwr/features/departments/department_detail_view/data/models/studies_type.dart";
import "package:topwr/features/departments/departments_view/data/models/department.dart";
import "package:topwr/features/digital_guide/business/accessibility_comments_manager.dart";
import "package:topwr/features/digital_guide/data/models/digital_guide_response.dart";
import "package:topwr/features/digital_guide/tabs/rooms/data/models/digital_guide_room.dart";
import "package:topwr/features/digital_guide/tabs/transportation/data/models/digital_guide_transportation.dart";
import "package:topwr/features/digital_guide_objects/data/models/digital_guide_object_model.dart";
import "package:topwr/features/guide_detail_view/data/models/guide_details.dart";
import "package:topwr/features/guide_view/data/models/guide_data.dart";
import "package:topwr/features/multilayer_map/data/model/aed.dart";
import "package:topwr/features/multilayer_map/data/model/bicycle_shower.dart";
import "package:topwr/features/multilayer_map/data/model/building.dart";
import "package:topwr/features/multilayer_map/data/model/library.dart";
import "package:topwr/features/multilayer_map/data/model/multilayer_item.dart";
import "package:topwr/features/multilayer_map/data/model/pink_box.dart";
import "package:topwr/features/multilayer_map/data/model/polinka_station.dart";
import "package:topwr/features/newsfeed/data/models/newsfeed_models.dart";
import "package:topwr/features/notifications/data/models/notification_model.dart";
import "package:topwr/features/parkings/parkings_view/models/parking.dart";
import "package:topwr/features/planner_advert/data/models/planner_banner_models.dart";
import "package:topwr/features/remote_config/data/models/remote_config.dart";
import "package:topwr/features/science_club/science_club_detail_view/model/science_club_details.dart";
import "package:topwr/features/science_club/science_clubs_filters/model/sci_club_type.dart";
import "package:topwr/features/science_club/science_clubs_filters/model/tags.dart";
import "package:topwr/features/science_club/science_clubs_view/model/science_clubs.dart";
import "package:topwr/features/sks/sks_chart/data/models/sks_chart_data.dart";
import "package:topwr/features/sks/sks_favourite_dishes/data/repository/sks_favourite_dishes_repository.dart";
import "package:topwr/features/sks/sks_menu/data/models/dish_category_enum.dart";
import "package:topwr/features/sks/sks_menu/data/models/sks_menu_data.dart";
import "package:topwr/features/sks/sks_menu/data/models/sks_menu_response.dart";
import "package:topwr/features/sks/sks_menu/data/models/sks_opening_hours.dart";
import "package:topwr/features/sks/sks_people_live/data/models/sks_user_data.dart";
import "package:topwr/theme/hex_color.dart";
import "package:topwr/utils/datetime_utils.dart";

const mockRemoteConfig = RemoteConfig(
  cmsReferenceNumber: 0,
  daySwapLookahead: 7,
  translatorReferenceNumber: 0,
  sksMicroserviceUrl: "",
  parkingMicroserviceUrl: "",
);

/// Relative dates keep countdown and day-swap stories populated without API calls.
final mockAcademicCalendarWithSwaps = () {
  final t = today;
  return AcademicCalendarWithSwaps(
    calendarData: AcademicCalendar(
      id: 2,
      name: "Semestr letni 2025/2026",
      semesterStartDate: t.subtract(const Duration(days: 65)),
      examSessionStartDate: t.add(const Duration(days: 50)),
      examSessionLastDate: t.add(const Duration(days: 70)),
      isFirstWeekEven: false,
      createdAt: t.subtract(const Duration(days: 80)),
      updatedAt: t.subtract(const Duration(days: 10)),
    ),
    daySwaps: IList<DaySwapData>([
      DaySwapData(
        id: 1,
        academicCalendarId: 2,
        date: t.add(const Duration(days: 2)),
        changedWeekday: WeekdayEnum.monday,
        changedDayIsEven: false,
        createdAt: t.subtract(const Duration(days: 10)),
        updatedAt: t.subtract(const Duration(days: 10)),
      ),
      DaySwapData(
        id: 2,
        academicCalendarId: 2,
        date: t.add(const Duration(days: 5)),
        changedWeekday: WeekdayEnum.friday,
        changedDayIsEven: true,
        createdAt: t.subtract(const Duration(days: 10)),
        updatedAt: t.subtract(const Duration(days: 10)),
      ),
    ]),
  );
}();

const mockChangelog = Changelog(
  name: "ToPWR 1.13.0",
  changes: IListConst([
    ChangelogChange(changeType: TypeOfChange.feature, name: "Dodano widok oblozenia Strefy Kultury Studenckiej"),
    ChangelogChange(changeType: TypeOfChange.fix, name: "Usprawniono wyswietlanie parkingow kampusowych"),
  ]),
);

const mockAboutUs = (
  description:
      "<p><b>ToPWR</b> to mobilny przewodnik po Politechnice Wroclawskiej tworzony przez studentow Solvro.</p>",
  photo: ImageData(url: ""),
  socialLinks: IListConst([
    SocialLinksData(url: "https://topwr.app", name: "Strona ToPWR"),
    SocialLinksData(url: "https://github.com/Solvro", name: "GitHub Solvro"),
    SocialLinksData(url: "https://www.linkedin.com/company/solvro", name: "LinkedIn Solvro"),
  ]),
  multiversionTeam: IListConst([
    (
      versionName: "1.12.0",
      members: IListConst([
        (
          teamMemberName: "Zespol Solvro",
          image: ImageData(url: ""),
          subtitleForMilestone: "Rozwoj aplikacji ToPWR",
          socialLinks: IListConst(["https://github.com/Solvro"]),
        ),
      ]),
    ),
    (
      versionName: "1.13.0",
      members: IListConst([
        (
          teamMemberName: "Zespol Solvro",
          image: ImageData(url: ""),
          subtitleForMilestone: "Projekt, design i rozwoj aplikacji ToPWR",
          socialLinks: IListConst(["https://github.com/Solvro"]),
        ),
      ]),
    ),
  ]),
);

final mockDepartments = IList<Department>(const [
  Department(
    id: 1,
    name: "Wydział Architektury",
    code: "W1",
    betterCode: "WA",
    gradientStart: "#BFBEBE",
    gradientStop: "#868585",
    branch: Branch.main,
  ),
  Department(
    id: 2,
    name: "Wydział Budownictwa Lądowego i Wodnego",
    code: "W2",
    betterCode: "WBLIW",
    gradientStart: "#CA6846",
    gradientStop: "#FFA07E",
    branch: Branch.main,
  ),
  Department(
    id: 5,
    name: "Wydział Informatyki i Telekomunikacji",
    code: "W4",
    betterCode: "WIT",
    gradientStart: "#7A2229",
    gradientStop: "#B74A53",
    branch: Branch.main,
  ),
]);

const mockDepartmentDetails = DepartmentDetails(
  id: 5,
  name: "Wydział Informatyki i Telekomunikacji",
  code: "W4",
  betterCode: "WIT",
  logo: ImageData(url: ""),
  gradientStart: "#7A2229",
  gradientStop: "#B74A53",
  addressLine1: "Wybrzeze Wyspianskiego 27",
  addressLine2: "50-370 Wroclaw",
  fieldsOfStudy: IListConst([
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
  departmentLinks: IListConst([
    SocialLinksData(url: "https://wit.pwr.edu.pl", name: "Strona wydzialu"),
    SocialLinksData(url: "https://www.facebook.com/WIT.PWr", name: "Facebook"),
  ]),
);

final mockGuideArticles = IList<GuideData>(const [
  GuideData(
    id: 2,
    title: "Zapisy na zajęcia",
    shortDesc: "Wszystko o rejestracji na przedmioty na naszej uczelni.",
    image: ImageData(url: ""),
    order: 1,
  ),
  GuideData(
    id: 4,
    title: "Legitymacja studencka",
    shortDesc: "Sprawdź, jak przedłużyć ważność Twojej legitymacji.",
    image: ImageData(url: ""),
    order: 2,
  ),
  GuideData(
    id: 1,
    title: "Akademiki",
    shortDesc: "Sprawdź, jak możesz otrzymać miejsce w akademiku.",
    image: ImageData(url: ""),
    order: 4,
  ),
  GuideData(
    id: 9,
    title: "Parkingi",
    shortDesc: "Dowiedz się, jak ogarnąć parking na PWr.",
    image: ImageData(url: ""),
    order: 5,
  ),
]);

final mockGuideDetails = GuideDetails(
  title: "Zapisy na zajęcia",
  description:
      "<h2>Zapisy na zajęcia</h2><p>Sprawdź terminy rejestracji w systemie uczelnianym i wybierz grupy zajęciowe zgodnie z planem studiów.</p>",
  shortDesc: "Wszystko o rejestracji na przedmioty na naszej uczelni.",
  image: const ImageData(url: ""),
  createdAt: DateTime.utc(2026, 2),
  updatedAt: DateTime.utc(2026, 4, 20),
  guideAuthors: const IListConst([
    GuideAuthor(
      name: "Zespol ToPWR",
      role: GuideAuthorRole(role: GuideAuthorRoleType.author),
    ),
  ]),
  guideQuestions: IListConst([
    GuideQuestion(
      title: "Gdzie znaleźć terminy rejestracji?",
      answer: "<p>Terminy znajdziesz w USOS i komunikatach wydziałowych.</p>",
      createdAt: DateTime.utc(2026, 2),
      updatedAt: DateTime.utc(2026, 4, 20),
      order: 1,
    ),
    GuideQuestion(
      title: "Co przygotować przed zapisami?",
      answer: "<p>Sprawdź plan studiów, limity miejsc i preferowane grupy.</p>",
      createdAt: DateTime.utc(2026, 2),
      updatedAt: DateTime.utc(2026, 4, 20),
      order: 2,
    ),
  ]),
);

const mockNewsArticles = IListConst<Article>([
  Article(
    imageLink: "",
    title: "15 pomyslow na nasza uczelnie. Znamy finalistow Polytechnica Nova 2026",
    url:
        "https://pwr.edu.pl/uczelnia/aktualnosci/15-pomyslow-na-nasza-uczelnie-znamy-finalistow-polytechnica-nova-2026-14102.html",
    date: "20.03.2026",
    categories: ["dzialania spoleczne", "zycie uczelni"],
    previewText: "Od bezpieczenstwa i zielonych przestrzeni, przez nowoczesna dydaktyke, az po laboratoria badawcze.",
  ),
  Article(
    imageLink: "",
    title: "Parkingi na PWr",
    url: "https://topwr.solvro.pl/guide/9",
    date: "05.05.2026",
    categories: ["kampus"],
    previewText: "Dowiedz sie, jak ogarnac parking na Politechnice Wroclawskiej.",
  ),
]);

final mockScienceClubs = IList<ScienceClub>([
  ScienceClub(
    id: 1365,
    name: "Solvro",
    organizationStatus: ScienceClubStatus.active,
    source: ScienceClubSource.manualEntry,
    organizationType: ScienceClubType.scientificClub,
    coverPreview: false,
    isStrategic: true,
    branch: Branch.main,
    tags: const IListConst([Tag(tag: "Informatyka"), Tag(tag: "Zarządzanie Projektami")]),
    shortDescription: "Studencka organizacja tworząca aplikacje dla społeczności akademickiej PWr.",
    department: mockDepartments[2],
  ),
  ScienceClub(
    id: 1399,
    name: "Koło Naukowe CAD/FEM",
    organizationStatus: ScienceClubStatus.active,
    source: ScienceClubSource.studentDepartment,
    organizationType: ScienceClubType.scientificClub,
    coverPreview: false,
    isStrategic: false,
    branch: Branch.main,
    tags: const IListConst([Tag(tag: "Mechanika"), Tag(tag: "Konstrukcja")]),
    shortDescription: "Projektowanie i symulacje inżynierskie.",
    department: mockDepartments[1],
  ),
]);

final mockScienceClubDetails = ScienceClubDetails(
  name: "Solvro",
  enName: "Solvro",
  source: ScienceClubSource.manualEntry,
  isStrategic: true,
  description: "Studencka organizacja tworząca aplikacje dla społeczności akademickiej PWr.",
  enDescription: "Student organization building apps for the Wroclaw Tech community.",
  cover: const ImageData(url: ""),
  logo: const ImageData(url: ""),
  department: mockDepartments[2],
  tags: mockScienceClubTags,
  links: const IListConst([
    SocialLinksData(url: "https://solvro.pwr.edu.pl", name: "Strona Solvro"),
    SocialLinksData(url: "https://github.com/Solvro", name: "GitHub"),
  ]),
);

const mockScienceClubTags = IListConst([
  Tag(tag: "Informatyka"),
  Tag(tag: "Zarzadzanie Projektami"),
  Tag(tag: "Mechanika"),
  Tag(tag: "Konstrukcja"),
]);

final mockCalendarYearEvents = IList<CalendarYearEvents>([
  (
    year: today.year,
    events: IList<CalendarMonthEvents>([
      (
        month: today.month,
        events: IList<CalendarDayEvents>([
          (
            day: today.day,
            weekday: today.weekday,
            isToday: true,
            events: IList<SingleCalendarItem>([
              (
                name: "Matematyka dyskretna",
                location: "C-13, sala 1.27",
                hoursString: "09:15 - 10:45",
                description: "Wyklad",
                accentColor: HexColor("#2962FF"),
              ),
              (
                name: "Programowanie mobilne",
                location: "D-21",
                hoursString: "11:15 - 12:45",
                description: "Laboratorium",
                accentColor: HexColor("#7A2229"),
              ),
            ]),
          ),
        ]),
      ),
    ]),
  ),
]);

final mockNotifications = IList<NotificationModel>([
  NotificationModel(
    id: 1,
    title: "Zapisy na zajęcia",
    body: "Przypomnienie o rejestracji na przedmioty.",
    data: const NotificationPayload(route: "/guide/2"),
    wasSent: true,
    createdAt: DateTime.utc(2026, 5, 4),
  ),
  NotificationModel(
    id: 2,
    title: "Zmiana organizacji dnia",
    body: "Sprawdź kalendarz akademicki.",
    wasSent: true,
    createdAt: DateTime.utc(2026, 5, 2),
  ),
]);

const mockBuilding = Building(
  rawId: 1,
  name: "C-13",
  naturalName: "Serowiec",
  addressLine1: "Wyb. Wyspianskiego 23-25",
  addressLine2: "50-370 Wroclaw",
  latitude: 51.107546,
  longitude: 17.059038,
  externalDigitalGuideMode: ExternalDigitalGuideMode.digitalGuideBuilding,
  externalDigitalGuideIdOrUrl: "313",
  cover: ImageData(url: ""),
  branch: Branch.main,
);

const mockPolinkaStation = PolinkaStation(
  id: 1,
  name: "Polinka",
  campusId: 7,
  addressLine1: "Wyb. Wyspianskiego 27",
  addressLine2: "50-370 Wroclaw",
  latitude: 51.1079,
  longitude: 17.0586,
  branch: Branch.main,
  externalDigitalGuideMode: ExternalDigitalGuideMode.webUrl,
  externalDigitalGuideIdOrUrl: "https://topwr.solvro.pl/guide/8",
  photo: ImageData(url: ""),
);

const mockLibrary = Library(
  rawId: 1,
  title: "Biblioteka Kluczborska",
  room: "1.01",
  latitude: 51.1082,
  longitude: 17.0601,
  photo: ImageData(url: ""),
  building: mockBuilding,
  branch: Branch.main,
);

const mockAed = Aed(
  rawId: 1,
  latitude: 51.1077,
  longitude: 17.0592,
  photo: ImageData(url: ""),
  addressLine1: "Wyb. Wyspianskiego 23-25",
  addressLine2: "Hol glowny C-13",
  instructions: "AED znajduje sie przy portierni.",
  building: mockBuilding,
  branch: Branch.main,
);

const mockBicycleShower = BicycleShower(
  rawId: 1,
  room: "0.12",
  instructions: "Prysznic rowerowy znajduje sie przy szatni na parterze.",
  latitude: 51.1075,
  longitude: 17.0594,
  photo: ImageData(url: ""),
  building: mockBuilding,
  branch: Branch.main,
);

const mockPinkBox = PinkBox(
  rawId: 1,
  roomOrNearby: "Hol przy windach",
  latitude: 51.1076,
  longitude: 17.0596,
  photo: ImageData(url: ""),
  building: mockBuilding,
  branch: Branch.main,
);

const mockParking = Parking(
  id: "2",
  parkingId: "2",
  numberOfPlaces: "55",
  symbol: "C13",
  type: "O",
  name: "Polinka",
  openHour: "00:00:00",
  closeHour: "00:00:00",
  places: "54",
  geoLan: "17.06094",
  geoLat: "51.10804",
  photo: "",
  miniaturePhoto: "",
  active: "1",
  showPark: "1",
  lp: "",
  address: "wybrzeze Stanislawa Wyspianskiego 25",
  trend: "0",
  access: ParkingAccess.students,
);

const mockMultilayerItems = IListConst<MultilayerItem>([
  BuildingItem(building: mockBuilding),
  PolinkaItem(station: mockPolinkaStation),
  LibraryItem(library: mockLibrary),
  AedItem(aed: mockAed),
  BicycleShowerItem(shower: mockBicycleShower),
  PinkBoxItem(pinkBox: mockPinkBox),
]);

const mockParkings = IListConst<Parking>([mockParking]);

final mockPlannerBanner = PlannerBanner(
  id: 1,
  title: "Planer zajec ToPWR",
  description: "Sprawdz planer zajec i wygodnie zaplanuj semestr.",
  url: "https://topwr.solvro.pl/",
  textColor: "#FFFFFF",
  backgroundColor: "#FF5733",
  titleColor: "#FFFFFF",
  visibleFrom: DateTime(2026),
  visibleUntil: DateTime(2027),
  createdAt: DateTime(2026),
  updatedAt: DateTime(2026),
);

const mockDigitalGuideResponse = DigitalGuideResponse(
  id: 1,
  externalId: 313,
  translations: DigitalGuideTranslations(
    plTranslation: DigitalGuideTranslation(
      name: "C-13 Serowiec",
      extendedName: "Budynek C-13 Politechniki Wroclawskiej",
      address: "Wyb. Wyspianskiego 23-25, 50-370 Wroclaw",
      evacuationDescription: "Kieruj sie oznaczeniami ewakuacyjnymi do najblizszej klatki schodowej.",
    ),
  ),
  numberOfStoreys: 5,
  canAssistanceDog: true,
  isInductionLoop: true,
  isMicroNavigationSystem: false,
  areGuidancePaths: true,
  areBrailleBoards: true,
  areLargeFontBoards: true,
  isSignLanguageInterpreter: false,
  areEmergencyChairs: true,
  phoneNumbers: ["71 320 00 00"],
  surroundingId: 1,
  images: [],
  evacuationMapId: 1,
  locationMapId: 1,
  levelsIndices: [0, 1, 2, 3, 4],
  accessId: 1,
  accessibilityLevelForMotorDisability: 1,
  accessibilityLevelForBlind: 2,
  accessibilityLevelForVisuallyImpaired: 2,
  accessibilityLevelForHardOfHearing: 1,
  accessibilityLevelForHighSensorySensitivity: 1,
  accessibilityLevelForCognitiveDifficulties: 1,
);

const mockSksOpeningHoursPl = OpeningHours(
  language: "pl",
  canteen: "pon.-czw. 9.00 - 15.00 pt. 10.00 - 14.30",
  cafe: "8.00 - 20.00",
);

const mockSksOpeningHoursEn = OpeningHours(
  language: "en",
  canteen: "Mon. - Thu. 8.00 am - 4.00 pm Fri. 7.30 am - 3.00 pm",
  cafe: "7.00 am - 8.15 pm",
);

final mockSksMenuDishes = IList<SksMenuDishBase>(const [
  SksMenuDish(id: "70", name: "Surówka colesław", category: DishCategory.salad, size: "100g", price: "4.50"),
  SksMenuDish(
    id: "217",
    name: "Krem marchewk. z groszk. ptysiowym",
    category: DishCategory.soup,
    size: "300ml",
    price: "7.50",
  ),
  SksMenuDish(
    id: "370",
    name: "Rosół królewski z kurczakiem",
    category: DishCategory.soup,
    size: "300ml",
    price: "7.50",
  ),
  SksMenuDish(
    id: "450",
    name: "Kotlety z kaszą i warzywami",
    category: DishCategory.vegetarianDish,
    size: "250g",
    price: "17.00",
  ),
  SksMenuDish(
    id: "207",
    name: "Filet drobiowy w sosie kaparowym",
    category: DishCategory.meatDish,
    size: "110/50g",
    price: "17.00",
  ),
  SksMenuDish(id: "226", name: "Gulasz wieprzowy", category: DishCategory.meatDish, size: "200g", price: "17.00"),
  SksMenuDish(
    id: "118",
    name: "Kotlet schabowy tradycyjny",
    category: DishCategory.meatDish,
    size: "130g",
    price: "17.00",
  ),
  SksMenuDish(
    id: "189",
    name: "Ziemniaki puree z masłem i koperkiem",
    category: DishCategory.sideDish,
    size: "250g",
    price: "5.00",
  ),
  SksMenuDish(
    id: "264",
    name: "Kompot agrestowo- jabłkowy",
    category: DishCategory.drink,
    size: "200ml",
    price: "3.00",
  ),
]);

final mockExtendedSksMenuResponse = ExtendedSksMenuResponse(
  isMenuOnline: true,
  lastUpdate: DateTime.utc(2026, 5, 6, 7, 45, 1, 74),
  meals: mockSksMenuDishes.cast<SksMenuDish>().toIList(),
  technicalInfos: const IList.empty(),
  openingHours: mockSksOpeningHoursPl,
);

final SksFavouriteDishesMap mockSksFavouriteDishesMap = {
  for (final dish in mockExtendedSksMenuResponse.meals)
    dish.id: (
      dish: SksMenuDishMinimal(id: dish.id, name: dish.name, category: dish.category),
      isSubscribed: dish.id == mockExtendedSksMenuResponse.meals.first.id,
    ),
}.lock;

final mockSksChartData = IList<SksChartData>([
  SksChartData(activeUsers: 18, movingAverage21: 22, externalTimestamp: DateTime(2026, 5, 6, 8)),
  SksChartData(activeUsers: 31, movingAverage21: 27, externalTimestamp: DateTime(2026, 5, 6, 9)),
  SksChartData(activeUsers: 47, movingAverage21: 34, externalTimestamp: DateTime(2026, 5, 6, 10)),
  SksChartData(activeUsers: 69, movingAverage21: 41, externalTimestamp: DateTime(2026, 5, 6, 11)),
  SksChartData(activeUsers: 88, movingAverage21: 53, externalTimestamp: DateTime(2026, 5, 6, 12)),
  SksChartData(activeUsers: 76, movingAverage21: 56, externalTimestamp: DateTime(2026, 5, 6, 13)),
  SksChartData(activeUsers: 54, movingAverage21: 48, externalTimestamp: DateTime(2026, 5, 6, 14)),
]);

final mockSksUserData = SksUserData(
  externalTimestamp: DateTime.utc(2026, 5, 6, 7, 45),
  activeUsers: 75,
  movingAverage21: 39,
  createdAt: DateTime.utc(2026, 5, 5, 22, 0, 0, 136),
  updatedAt: DateTime.utc(2026, 5, 6, 7, 49, 0, 185),
  trend: Trend.increasing,
  isResultRecent: true,
  nextUpdateTimestamp: DateTime.utc(2026, 5, 6, 7, 54, 30, 185),
);

const mockDigitalGuideTransportationC13 = DigitalGuideTransportation(
  id: 1,
  building: 313,
  translations: DigitalGuideTranslationsTransportation(
    pl: DigitalGuideTranslationTransportation(
      nearestPublicTransportStop: "Most Grunwaldzki",
      nearestPublicTransportStopDistanceComment:
          "Przystanek znajduje się przy osi Grunwaldzkiej, około 230 m od wejścia do C-13.",
      arePassTrafficLightsFromStopToEntryComment:
          "Na dojściu od przystanku trzeba przejść przez sygnalizowane przejście dla pieszych.",
      areNotPassTrafficLightsFromStopToEntryComment: "",
      alternativePublicTransportStop: "Plac Grunwaldzki",
      alternativePublicTransportStopDistanceComment: "Alternatywny przystanek znajduje się około 450 m od budynku.",
      arePassTrafficLightsFromStopToEntryAltRoadComment: "Trasa prowadzi przez przejścia z sygnalizacją świetlną.",
      areNotPassTrafficLightsFromStopToEntryAltRoadComment: "",
      nearestPublicParkingLocation: "Parking przy wybrzeżu Wyspiańskiego",
      isPaidParkingComment: "Parking miejski jest płatny w dni robocze zgodnie z taryfą strefy.",
      nearestUniversityParkingLocation: "Parking kampusowy przy C-13",
      nearestDisabledParkingSpaces:
          "Miejsca dla osób z niepełnosprawnością są wyznaczone przy głównych ciągach pieszych kampusu.",
      areBicycleStandsComment: "Stojaki rowerowe znajdują się przy wejściach do budynku C-13.",
      isCityBikeStationComment: "Najbliższa stacja roweru miejskiego znajduje się w rejonie Placu Grunwaldzkiego.",
      isBicyclePathLeadToBuildingComment: "Do kampusu prowadzi infrastruktura rowerowa wzdłuż osi Grunwaldzkiej.",
      isBicyclePathLeadClearlySeparatedComment: "Część trasy jest oddzielona od ruchu samochodowego.",
      areObstaclesForWheelchairUserComment: "Główne dojście prowadzi utwardzonym chodnikiem.",
      areObstaclesForBlindComment:
          "Na trasie mogą występować słupki i elementy małej architektury przy ciągach pieszych.",
      areFacilitiesForBlindFromStopToEntryComment: "Przejścia dla pieszych w rejonie kampusu mają obniżone krawężniki.",
      areObstaclesForWheelchairUserAltRoadComment:
          "Alternatywna trasa jest dłuższa, ale prowadzi utwardzonymi chodnikami.",
      areObstaclesForBlindFromStopToEntryAltRoadComment:
          "Na trasie alternatywnej występują skrzyżowania i przystanki o dużym natężeniu ruchu.",
      areFacilitiesForBlindFromStopToEntryAltRoadComment:
          "W rejonie przejść znajdują się obniżone krawężniki i oznaczenia fakturowe.",
    ),
  ),
  nearestPublicTransportStopDistance: 230,
  arePassTrafficLightsFromStopToEntry: "yes",
  areNotPassTrafficLightsFromStopToEntry: "no",
  alternativePublicTransportStopDistance: 450,
  arePassTrafficLightsFromStopToEntryAltRoad: "yes",
  areNotPassTrafficLightsFromStopToEntryAltRoad: "no",
  nearestPublicParkingLocationDistance: 160,
  isPaidParking: "yes",
  nearestUniversityParkingLocationDistance: 120,
  nearestDisabledParkingSpacesDistance: 90,
  areBicycleStands: "yes",
  isCityBikeStation: "yes",
  cityBikeStationDistance: 450,
  isBicyclePathLeadToBuilding: "yes",
  distanceToBicyclePath: 80,
  isBicyclePathLeadClearlySeparated: "yes",
  areObstaclesForBlind: "yes",
  areObstaclesForWheelchairUser: "no",
  areFacilitiesForBlindFromStopToEntry: "yes",
  areObstaclesForWheelchairUserAltRoad: "no",
  areObstaclesForBlindFromStopToEntryAltRoad: "yes",
  areFacilitiesForBlindFromStopToEntryAltRoad: "yes",
  dailyTramBusLines: "1, 2, 4, 10, 16, 33",
  alternativeDailyTramBusLinesStop: "2, 4, 10, 33, autobusy kampusowe",
);

/// Minimal [DigitalGuideRoom] for Widgetbook (room detail / room level lists).
const mockDigitalGuideRoom = DigitalGuideRoom(
  id: 1,
  translations: DigitalGuideTranslationsRoom(
    pl: DigitalGuideTranslationRoom(
      name: "Sala 1.27",
      roomPurpose: "Sala dydaktyczna w budynku C-13",
      location: "Pierwsze piętro, skrzydło od strony wybrzeża Wyspiańskiego",
      workingDaysAndHours: "pon.-pt. 8:00-18:00",
      areEntrancesComment: "",
      isUseRestrictedComment: "",
      isOneLevelFloorComment: "",
      areSeatsComment: "",
      areDimensionsAllowFreeMovementComment: "",
      arePlacesForWheelchairsComment: "",
      arePlacesAccessibleFromMainEntranceComment: "",
      areAnyDangerousElementsComment: "",
      isGenerallyAvailableDeskComment: "",
      isSpaceUnderCounterComment: "",
      areElectricalOutletsComment: "",
      isGoodFloorRoomContrastComment: "",
      isGoodLitComment: "",
      isFloorShinyComment: "",
      isBlackboardComment: "",
      areMovableElementsComment: "",
      isRoomCausesEchoComment: "",
      isNoisyComment: "",
      areFlashingDevicesComment: "",
      hasInductionLoopComment: "",
      comment: "",
    ),
  ),
  roomStairs: [],
  platforms: [],
  imagesIds: null,
  orderNumber: 1,
  areEntrances: "yes",
  isUseRestricted: "no",
  isOneLevelFloor: "yes",
  areSeats: "yes",
  areDimensionsAllowFreeMovement: "yes",
  arePlacesForWheelchairs: "yes",
  arePlacesAccessibleFromMainEntrance: "yes",
  areAnyDangerousElements: "no",
  isGenerallyAvailableDesk: "yes",
  isSpaceUnderCounter: "yes",
  areElectricalOutlets: "yes",
  isGoodFloorRoomContrast: "yes",
  isGoodLit: "yes",
  isFloorShiny: "no",
  isBlackboard: "yes",
  areMovableElements: "no",
  isRoomCausesEcho: "no",
  isNoisy: "no",
  areFlashingDevices: "no",
  hasInductionLoop: "no",
  building: 1,
  doors: [],
);

/// Minimal [DigitalGuideObjectModel] for object feature stories.
const mockDigitalGuideObjectModel = DigitalGuideObjectModel(
  id: 1,
  translations: DigitalGuideObjectTranslations(
    pl: DigitalGuideObjectTranslation(name: "C-13 Serowiec", address: "Wyb. Wyspiańskiego 23-25, 50-370 Wrocław"),
  ),
  isPossibilityToEnterWithAssistanceDog: false,
  isMicronavigationSystem: false,
  areGuidancePaths: false,
  areInformationBoardsWithBrailleDescription: false,
  areInformationBoardsWithLargeFont: false,
  accessibilityLevelForMotorDisability: 1,
  accessibilityLevelForBlind: 1,
  accessibilityLevelForVisuallyImpaired: 1,
  accessibilityLevelForHardOfHearing: 1,
  accessibilityLevelForHighSensorySensitivity: 1,
  accessibilityLevelForCognitiveDifficulties: 1,
  images: [],
);

/// No-op implementation for stories that only need an [AccessibilityCommentsManager] instance.
final class EmptyAccessibilityCommentsManager extends AccessibilityCommentsManager {
  EmptyAccessibilityCommentsManager();

  @override
  IList<String> getCommentsListForBlind() => const IList.empty();

  @override
  IList<String> getCommentsListForCognitiveImpairment() => const IList.empty();

  @override
  IList<String> getCommentsListForHearingImpairment() => const IList.empty();

  @override
  IList<String> getCommentsListForLowVision() => const IList.empty();

  @override
  IList<String> getCommentsListForMotorImpairment() => const IList.empty();

  @override
  IList<String> getCommentsListForSensorySensitivity() => const IList.empty();
}
