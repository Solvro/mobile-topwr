import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_pl.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[Locale('pl')];

  /// No description provided for @home_screen_greeting.
  ///
  /// In pl, this message translates to:
  /// **'Cześć, miło Cię widzieć'**
  String get home_screen_greeting;

  /// No description provided for @even_monday.
  ///
  /// In pl, this message translates to:
  /// **'w Parzysty Poniedziałek'**
  String get even_monday;

  /// No description provided for @even_tuesday.
  ///
  /// In pl, this message translates to:
  /// **'w Parzysty Wtorek'**
  String get even_tuesday;

  /// No description provided for @even_wednesday.
  ///
  /// In pl, this message translates to:
  /// **'w Parzystą Środę'**
  String get even_wednesday;

  /// No description provided for @even_thursday.
  ///
  /// In pl, this message translates to:
  /// **'w Parzysty Czwartek'**
  String get even_thursday;

  /// No description provided for @even_friday.
  ///
  /// In pl, this message translates to:
  /// **'w Parzysty Piątek'**
  String get even_friday;

  /// No description provided for @even_saturday.
  ///
  /// In pl, this message translates to:
  /// **'w Parzystą Sobotę'**
  String get even_saturday;

  /// No description provided for @even_sunday.
  ///
  /// In pl, this message translates to:
  /// **'w Parzystą Niedzielę'**
  String get even_sunday;

  /// No description provided for @odd_monday.
  ///
  /// In pl, this message translates to:
  /// **'w Nieparzysty Poniedziałek'**
  String get odd_monday;

  /// No description provided for @odd_tuesday.
  ///
  /// In pl, this message translates to:
  /// **'w Nieparzysty Wtorek'**
  String get odd_tuesday;

  /// No description provided for @odd_wednesday.
  ///
  /// In pl, this message translates to:
  /// **'w Nieparzystą Środę'**
  String get odd_wednesday;

  /// No description provided for @odd_thursday.
  ///
  /// In pl, this message translates to:
  /// **'w Nieparzysty Czwartek'**
  String get odd_thursday;

  /// No description provided for @odd_friday.
  ///
  /// In pl, this message translates to:
  /// **'w Nieparzysty Piątek'**
  String get odd_friday;

  /// No description provided for @odd_saturday.
  ///
  /// In pl, this message translates to:
  /// **'w Nieparzystą Sobotę'**
  String get odd_saturday;

  /// No description provided for @odd_sunday.
  ///
  /// In pl, this message translates to:
  /// **'w Nieparzystą Niedzielę'**
  String get odd_sunday;

  /// No description provided for @holiday_monday.
  ///
  /// In pl, this message translates to:
  /// **'w Wakacyjny Poniedziałek'**
  String get holiday_monday;

  /// No description provided for @holiday_tuesday.
  ///
  /// In pl, this message translates to:
  /// **'w Wakacyjny Wtorek'**
  String get holiday_tuesday;

  /// No description provided for @holiday_wednesday.
  ///
  /// In pl, this message translates to:
  /// **'w Wakacyjną Środę'**
  String get holiday_wednesday;

  /// No description provided for @holiday_thursday.
  ///
  /// In pl, this message translates to:
  /// **'w Wakacyjny Czwartek'**
  String get holiday_thursday;

  /// No description provided for @holiday_friday.
  ///
  /// In pl, this message translates to:
  /// **'w Wakacyjny Piątek'**
  String get holiday_friday;

  /// No description provided for @holiday_saturday.
  ///
  /// In pl, this message translates to:
  /// **'w Wakacyjną Sobotę'**
  String get holiday_saturday;

  /// No description provided for @holiday_sunday.
  ///
  /// In pl, this message translates to:
  /// **'w Wakacyjną Niedzielę'**
  String get holiday_sunday;

  /// No description provided for @exam_monday.
  ///
  /// In pl, this message translates to:
  /// **'w Egzaminacyjny Poniedziałek'**
  String get exam_monday;

  /// No description provided for @exam_tuesday.
  ///
  /// In pl, this message translates to:
  /// **'w Egzaminacyjny Wtorek'**
  String get exam_tuesday;

  /// No description provided for @exam_wednesday.
  ///
  /// In pl, this message translates to:
  /// **'w Egzaminacyjną Środę'**
  String get exam_wednesday;

  /// No description provided for @exam_thursday.
  ///
  /// In pl, this message translates to:
  /// **'w Egzaminacyjny Czwartek'**
  String get exam_thursday;

  /// No description provided for @exam_friday.
  ///
  /// In pl, this message translates to:
  /// **'w Egzaminacyjny Piątek'**
  String get exam_friday;

  /// No description provided for @exam_saturday.
  ///
  /// In pl, this message translates to:
  /// **'w Egzaminacyjną Sobotę'**
  String get exam_saturday;

  /// No description provided for @exam_sunday.
  ///
  /// In pl, this message translates to:
  /// **'w Egzaminacyjną Niedzielę'**
  String get exam_sunday;

  /// No description provided for @follow_solvro.
  ///
  /// In pl, this message translates to:
  /// **'Obserwuj nas na socialach!'**
  String get follow_solvro;

  /// No description provided for @unknown_day.
  ///
  /// In pl, this message translates to:
  /// **'w ten piękny dzień!'**
  String get unknown_day;

  /// No description provided for @read_more.
  ///
  /// In pl, this message translates to:
  /// **'Czytaj dalej'**
  String get read_more;

  /// No description provided for @whats_up.
  ///
  /// In pl, this message translates to:
  /// **'Co słychać?'**
  String get whats_up;

  /// No description provided for @study_circles.
  ///
  /// In pl, this message translates to:
  /// **'Organizacje studenckie'**
  String get study_circles;

  /// No description provided for @days.
  ///
  /// In pl, this message translates to:
  /// **'dni'**
  String get days;

  /// No description provided for @to_start_session.
  ///
  /// In pl, this message translates to:
  /// **'do rozpoczęcia sesji'**
  String get to_start_session;

  /// No description provided for @map_button.
  ///
  /// In pl, this message translates to:
  /// **'Mapa'**
  String get map_button;

  /// No description provided for @meet_our_team.
  ///
  /// In pl, this message translates to:
  /// **'Poznaj nas!'**
  String get meet_our_team;

  /// No description provided for @sections.
  ///
  /// In pl, this message translates to:
  /// **'Wydziały'**
  String get sections;

  /// No description provided for @list.
  ///
  /// In pl, this message translates to:
  /// **'Lista'**
  String get list;

  /// No description provided for @departments.
  ///
  /// In pl, this message translates to:
  /// **'Wydziały'**
  String get departments;

  /// No description provided for @department.
  ///
  /// In pl, this message translates to:
  /// **'Wydział'**
  String get department;

  /// No description provided for @search.
  ///
  /// In pl, this message translates to:
  /// **'Szukaj'**
  String get search;

  /// No description provided for @contact.
  ///
  /// In pl, this message translates to:
  /// **'Kontakt'**
  String get contact;

  /// No description provided for @about_us.
  ///
  /// In pl, this message translates to:
  /// **'O nas'**
  String get about_us;

  /// No description provided for @navigate.
  ///
  /// In pl, this message translates to:
  /// **'Nawiguj'**
  String get navigate;

  /// No description provided for @building_prefix.
  ///
  /// In pl, this message translates to:
  /// **'Budynek'**
  String get building_prefix;

  /// No description provided for @department_not_found.
  ///
  /// In pl, this message translates to:
  /// **'Nie znaleziono wydziału'**
  String get department_not_found;

  /// No description provided for @sci_circle_not_found.
  ///
  /// In pl, this message translates to:
  /// **'Nie znaleziono organizacji studenckich'**
  String get sci_circle_not_found;

  /// No description provided for @all.
  ///
  /// In pl, this message translates to:
  /// **'Wszystkie'**
  String get all;

  /// No description provided for @parkings_title.
  ///
  /// In pl, this message translates to:
  /// **'Parkingi'**
  String get parkings_title;

  /// No description provided for @parkings_not_found.
  ///
  /// In pl, this message translates to:
  /// **'Nie znaleziono parkingu'**
  String get parkings_not_found;

  /// No description provided for @building_not_found.
  ///
  /// In pl, this message translates to:
  /// **'Nie znaleziono budynku'**
  String get building_not_found;

  /// No description provided for @buildings_title.
  ///
  /// In pl, this message translates to:
  /// **'Budynki'**
  String get buildings_title;

  /// No description provided for @freePlaces.
  ///
  /// In pl, this message translates to:
  /// **'Wolne miejsca'**
  String get freePlaces;

  /// No description provided for @noChartData.
  ///
  /// In pl, this message translates to:
  /// **'Dane wykresów są niedostępne w nocy'**
  String get noChartData;

  /// No description provided for @offlineParkings.
  ///
  /// In pl, this message translates to:
  /// **'Błąd połączenia: niestety, moduł parkingów nie może poprawnie działać bez połączenia internetowego.'**
  String get offlineParkings;

  /// No description provided for @refresh.
  ///
  /// In pl, this message translates to:
  /// **'Odśwież'**
  String get refresh;

  /// No description provided for @offline_error_message.
  ///
  /// In pl, this message translates to:
  /// **'Wystąpił błąd podczas pobierania danych dotyczących '**
  String get offline_error_message;

  /// No description provided for @offline_try_again.
  ///
  /// In pl, this message translates to:
  /// **'Spróbuj ponownie później.'**
  String get offline_try_again;

  /// No description provided for @offline_news.
  ///
  /// In pl, this message translates to:
  /// **'wiadomości'**
  String get offline_news;

  /// No description provided for @offline_sci_clubs.
  ///
  /// In pl, this message translates to:
  /// **'kół naukowych'**
  String get offline_sci_clubs;

  /// No description provided for @offline_buildings.
  ///
  /// In pl, this message translates to:
  /// **'budynków'**
  String get offline_buildings;

  /// No description provided for @offline_departments.
  ///
  /// In pl, this message translates to:
  /// **'wydziałów'**
  String get offline_departments;

  /// No description provided for @offline_academic_calendar.
  ///
  /// In pl, this message translates to:
  /// **'kalendarza akademickiego'**
  String get offline_academic_calendar;

  /// No description provided for @offline_about_us.
  ///
  /// In pl, this message translates to:
  /// **'o nas'**
  String get offline_about_us;

  /// No description provided for @offline_department_details.
  ///
  /// In pl, this message translates to:
  /// **'wydziału'**
  String get offline_department_details;

  /// No description provided for @offline_guide_details.
  ///
  /// In pl, this message translates to:
  /// **'wpisu z przewodnika'**
  String get offline_guide_details;

  /// No description provided for @offline_guide_posts.
  ///
  /// In pl, this message translates to:
  /// **'wpisów z przewodnika'**
  String get offline_guide_posts;

  /// No description provided for @offline_changelog.
  ///
  /// In pl, this message translates to:
  /// **'zmian'**
  String get offline_changelog;

  /// No description provided for @guide.
  ///
  /// In pl, this message translates to:
  /// **'Przewodnik'**
  String get guide;

  /// No description provided for @deans_office.
  ///
  /// In pl, this message translates to:
  /// **'Dziekanat'**
  String get deans_office;

  /// No description provided for @fields_of_study.
  ///
  /// In pl, this message translates to:
  /// **'Kierunki'**
  String get fields_of_study;

  /// No description provided for @guide_about_us.
  ///
  /// In pl, this message translates to:
  /// **'O Nas!'**
  String get guide_about_us;

  /// No description provided for @guide_meet_creators.
  ///
  /// In pl, this message translates to:
  /// **'Poznaj twórców aplikacji mobilnej ToPWR!'**
  String get guide_meet_creators;

  /// No description provided for @guide_not_found.
  ///
  /// In pl, this message translates to:
  /// **'Nie znaleziono wpisów przewodnika'**
  String get guide_not_found;

  /// No description provided for @first_degree.
  ///
  /// In pl, this message translates to:
  /// **'I Stopnia'**
  String get first_degree;

  /// No description provided for @second_degree.
  ///
  /// In pl, this message translates to:
  /// **'II Stopnia'**
  String get second_degree;

  /// No description provided for @long_cycle.
  ///
  /// In pl, this message translates to:
  /// **'Jednolite magisterskie'**
  String get long_cycle;

  /// No description provided for @no_address.
  ///
  /// In pl, this message translates to:
  /// **'Brak adresu'**
  String get no_address;

  /// No description provided for @student_medias.
  ///
  /// In pl, this message translates to:
  /// **' Media studenckie'**
  String get student_medias;

  /// No description provided for @cultural_agendas.
  ///
  /// In pl, this message translates to:
  /// **'Agendy kultury'**
  String get cultural_agendas;

  /// No description provided for @scientific_cirlces.
  ///
  /// In pl, this message translates to:
  /// **'Koła naukowe'**
  String get scientific_cirlces;

  /// No description provided for @student_organizations.
  ///
  /// In pl, this message translates to:
  /// **'Organizacje studenckie'**
  String get student_organizations;

  /// No description provided for @org_types.
  ///
  /// In pl, this message translates to:
  /// **'Rodzaje organizacji'**
  String get org_types;

  /// No description provided for @categories.
  ///
  /// In pl, this message translates to:
  /// **'Kategorie tematyczne'**
  String get categories;

  /// No description provided for @filters.
  ///
  /// In pl, this message translates to:
  /// **'Filtry'**
  String get filters;

  /// No description provided for @clear.
  ///
  /// In pl, this message translates to:
  /// **'Wyczyść'**
  String get clear;

  /// No description provided for @filters_didnt_found_anything.
  ///
  /// In pl, this message translates to:
  /// **'Nie znaleziono żadnych filtrów'**
  String get filters_didnt_found_anything;

  /// No description provided for @street_abbreviation.
  ///
  /// In pl, this message translates to:
  /// **'ul.'**
  String get street_abbreviation;

  /// No description provided for @bug_report_title.
  ///
  /// In pl, this message translates to:
  /// **'Zgłoś błąd lub sugestię'**
  String get bug_report_title;

  /// No description provided for @bug_report_subtitle.
  ///
  /// In pl, this message translates to:
  /// **'Wyślij zgłoszenie bezpośrednio do twórców aplikacji.'**
  String get bug_report_subtitle;

  /// No description provided for @new_feature.
  ///
  /// In pl, this message translates to:
  /// **'Nowa funckcjonalność'**
  String get new_feature;

  /// No description provided for @bug.
  ///
  /// In pl, this message translates to:
  /// **'Błąd'**
  String get bug;

  /// No description provided for @praise.
  ///
  /// In pl, this message translates to:
  /// **'Pochwała'**
  String get praise;

  /// No description provided for @until_the_end_of_the_semester_break.
  ///
  /// In pl, this message translates to:
  /// **'do końca przerwy międzysemestralnej'**
  String get until_the_end_of_the_semester_break;

  /// No description provided for @until_the_session_ends.
  ///
  /// In pl, this message translates to:
  /// **'do zakończenia sesji'**
  String get until_the_session_ends;

  /// No description provided for @app_info.
  ///
  /// In pl, this message translates to:
  /// **'(informacje o aplikacji)'**
  String get app_info;

  /// No description provided for @show_license.
  ///
  /// In pl, this message translates to:
  /// **'Wyświetl licencję'**
  String get show_license;

  /// No description provided for @close.
  ///
  /// In pl, this message translates to:
  /// **'Zamknij'**
  String get close;

  /// No description provided for @no_version.
  ///
  /// In pl, this message translates to:
  /// **'Brak wersji'**
  String get no_version;

  /// No description provided for @places_currently_available.
  ///
  /// In pl, this message translates to:
  /// **'Aktualnie wolne miejsca'**
  String get places_currently_available;

  /// No description provided for @student_councils.
  ///
  /// In pl, this message translates to:
  /// **'Samorząd'**
  String get student_councils;

  /// No description provided for @hi_student.
  ///
  /// In pl, this message translates to:
  /// **'Hej studencie!'**
  String get hi_student;

  /// No description provided for @guide_development_info.
  ///
  /// In pl, this message translates to:
  /// **'Pamiętaj, że przewodnik jest wciąż w fazie rozwoju :)'**
  String get guide_development_info;

  /// No description provided for @guide_ideas_info.
  ///
  /// In pl, this message translates to:
  /// **'Masz ciekawy pomysł? Podziel się z nami!'**
  String get guide_ideas_info;

  /// No description provided for @guide_subject_default_content.
  ///
  /// In pl, this message translates to:
  /// **'Pomysł na rozwój ToPWR'**
  String get guide_subject_default_content;

  /// A message with a single parameter
  ///
  /// In pl, this message translates to:
  /// **'Używasz ToPWR nieprzerwanie od {days, plural, =1{1 dnia} other{{days} dni}}🔥'**
  String streak_counter(int days);

  /// No description provided for @last_modified.
  ///
  /// In pl, this message translates to:
  /// **'Ostatnia aktualizacja'**
  String get last_modified;

  /// No description provided for @created_at.
  ///
  /// In pl, this message translates to:
  /// **'Utworzono'**
  String get created_at;

  /// No description provided for @apply.
  ///
  /// In pl, this message translates to:
  /// **'Zastosuj'**
  String get apply;

  /// No description provided for @changes.
  ///
  /// In pl, this message translates to:
  /// **'Zmiany'**
  String get changes;

  /// No description provided for @version.
  ///
  /// In pl, this message translates to:
  /// **'wersja'**
  String get version;

  /// No description provided for @hey_check_out_the_new_features.
  ///
  /// In pl, this message translates to:
  /// **'Hej, sprawdź nowości'**
  String get hey_check_out_the_new_features;

  /// No description provided for @here_you_will_see_what_we_changed_in_the_latest_version.
  ///
  /// In pl, this message translates to:
  /// **'Tutaj zobaczysz co zmieniliśmy w najnowszej wersji'**
  String get here_you_will_see_what_we_changed_in_the_latest_version;

  /// No description provided for @data_come_from_website.
  ///
  /// In pl, this message translates to:
  /// **'Dane pochodzą ze strony'**
  String get data_come_from_website;

  /// No description provided for @sks_menu.
  ///
  /// In pl, this message translates to:
  /// **'SKS Menu'**
  String get sks_menu;

  /// No description provided for @home_screen.
  ///
  /// In pl, this message translates to:
  /// **'Ekran główny'**
  String get home_screen;

  /// No description provided for @sks_menu_salads.
  ///
  /// In pl, this message translates to:
  /// **'Surówki'**
  String get sks_menu_salads;

  /// No description provided for @sks_menu_main_soups.
  ///
  /// In pl, this message translates to:
  /// **'Zupy'**
  String get sks_menu_main_soups;

  /// No description provided for @sks_menu_vegetarian_dishes.
  ///
  /// In pl, this message translates to:
  /// **'Dania jarskie'**
  String get sks_menu_vegetarian_dishes;

  /// No description provided for @sks_menu_meat_dishes.
  ///
  /// In pl, this message translates to:
  /// **'Dania mięsne'**
  String get sks_menu_meat_dishes;

  /// No description provided for @sks_menu_side_dishes.
  ///
  /// In pl, this message translates to:
  /// **'Dodatki'**
  String get sks_menu_side_dishes;

  /// No description provided for @sks_menu_drinks.
  ///
  /// In pl, this message translates to:
  /// **'Kompoty i napoje'**
  String get sks_menu_drinks;

  /// No description provided for @sks_menu_desserts.
  ///
  /// In pl, this message translates to:
  /// **'Desery'**
  String get sks_menu_desserts;

  /// No description provided for @sks_full_name.
  ///
  /// In pl, this message translates to:
  /// **'Strefa Kultury Studenckiej'**
  String get sks_full_name;

  /// No description provided for @leave_a_review.
  ///
  /// In pl, this message translates to:
  /// **'Oceń aplikację'**
  String get leave_a_review;

  /// No description provided for @rest_header.
  ///
  /// In pl, this message translates to:
  /// **'Pozostałe'**
  String get rest_header;

  /// No description provided for @settings.
  ///
  /// In pl, this message translates to:
  /// **'Ustawienia'**
  String get settings;

  /// No description provided for @about_the_app.
  ///
  /// In pl, this message translates to:
  /// **'O aplikacji'**
  String get about_the_app;

  /// No description provided for @other_view.
  ///
  /// In pl, this message translates to:
  /// **'Inne'**
  String get other_view;

  /// No description provided for @map.
  ///
  /// In pl, this message translates to:
  /// **'Mapa'**
  String get map;

  /// No description provided for @report_change_title.
  ///
  /// In pl, this message translates to:
  /// **'Coś się zmieniło?'**
  String get report_change_title;

  /// No description provided for @report_change_button.
  ///
  /// In pl, this message translates to:
  /// **'Zgłoś zmianę'**
  String get report_change_button;

  /// No description provided for @report_change_email.
  ///
  /// In pl, this message translates to:
  /// **'kn.solvro@pwr.edu.pl'**
  String get report_change_email;

  /// No description provided for @report_change_subject.
  ///
  /// In pl, this message translates to:
  /// **'Sugestia zmiany - ToPWR'**
  String get report_change_subject;

  /// No description provided for @report_change_error_toast_message.
  ///
  /// In pl, this message translates to:
  /// **'Wystąpił błąd przy otwieraniu hiperłącza, sprawdź uprawnienia aplikacji'**
  String get report_change_error_toast_message;

  /// No description provided for @localization.
  ///
  /// In pl, this message translates to:
  /// **'Lokalizacja'**
  String get localization;

  /// No description provided for @amenities.
  ///
  /// In pl, this message translates to:
  /// **'Udogodnienia'**
  String get amenities;

  /// No description provided for @surroundings.
  ///
  /// In pl, this message translates to:
  /// **'Otoczenie'**
  String get surroundings;

  /// No description provided for @transport.
  ///
  /// In pl, this message translates to:
  /// **'Dojazd'**
  String get transport;

  /// No description provided for @entrances.
  ///
  /// In pl, this message translates to:
  /// **'Wejścia'**
  String get entrances;

  /// No description provided for @lifts.
  ///
  /// In pl, this message translates to:
  /// **'Windy'**
  String get lifts;

  /// No description provided for @adapted_toilets.
  ///
  /// In pl, this message translates to:
  /// **'Toalety dostosowane'**
  String get adapted_toilets;

  /// No description provided for @adapted_toilet_description.
  ///
  /// In pl, this message translates to:
  /// **'Toaleta dla osób z niepełnosprawnościami'**
  String get adapted_toilet_description;

  /// No description provided for @adapted_toilet_description_men.
  ///
  /// In pl, this message translates to:
  /// **'Toaleta dla mężczyzn z niepełnosprawnościami'**
  String get adapted_toilet_description_men;

  /// No description provided for @adapted_toilet_description_women.
  ///
  /// In pl, this message translates to:
  /// **'Toaleta dla kobiet z niepełnosprawnościami'**
  String get adapted_toilet_description_women;

  /// No description provided for @micro_navigation.
  ///
  /// In pl, this message translates to:
  /// **'Mikronawigacja'**
  String get micro_navigation;

  /// No description provided for @building_structure.
  ///
  /// In pl, this message translates to:
  /// **'Struktura budynku'**
  String get building_structure;

  /// No description provided for @room_information.
  ///
  /// In pl, this message translates to:
  /// **'Pomieszczenia'**
  String get room_information;

  /// No description provided for @evacuation.
  ///
  /// In pl, this message translates to:
  /// **'Ewakuacja'**
  String get evacuation;

  /// number of storeys with one parameter
  ///
  /// In pl, this message translates to:
  /// **'{number, plural, =1{{number} piętro} few{{number} piętra} other{{number} pięter}}'**
  String storeys(int number);

  /// No description provided for @assistance_dog.
  ///
  /// In pl, this message translates to:
  /// **'Do budynku i wszystkich jego pomieszczeń można wejść z psem asystującym i psem przewodnikiem'**
  String get assistance_dog;

  /// No description provided for @induction_loop.
  ///
  /// In pl, this message translates to:
  /// **'W budynku jest/są pętle indukcyjne'**
  String get induction_loop;

  /// No description provided for @micronavigation_system.
  ///
  /// In pl, this message translates to:
  /// **'W budynku zostały zainstalowane urządzenia systemu nawigacyjno-informacyjnego'**
  String get micronavigation_system;

  /// No description provided for @orientation_paths.
  ///
  /// In pl, this message translates to:
  /// **'W budynku zastosowane zostały ścieżki naprowadzające (dotykowe)'**
  String get orientation_paths;

  /// No description provided for @information_boards_with_braille_description.
  ///
  /// In pl, this message translates to:
  /// **'W budynku znajdują się czytelne tablice informacyjne zawierające opisy w alfabecie Braille\'a'**
  String get information_boards_with_braille_description;

  /// No description provided for @information_boards_with_large_font.
  ///
  /// In pl, this message translates to:
  /// **'W budynku znajdują się czytelne tablice informacyjne zawierające napisy w dużej czcionce'**
  String get information_boards_with_large_font;

  /// No description provided for @sign_language_interpreter.
  ///
  /// In pl, this message translates to:
  /// **'W budynku zapewniona jest możliwość skorzystania z usług tłumacza języka migowego'**
  String get sign_language_interpreter;

  /// No description provided for @emergency_chairs.
  ///
  /// In pl, this message translates to:
  /// **'W budynku zamieszczone zostały krzesła ewakuacyjne'**
  String get emergency_chairs;

  /// No description provided for @parking_location.
  ///
  /// In pl, this message translates to:
  /// **'Miejsca parkingowe znajdują się {location}'**
  String parking_location(Object location);

  /// No description provided for @parking_pwd_location.
  ///
  /// In pl, this message translates to:
  /// **'Miejsca parkingowe dla niepełnospranych znajdują się {location}'**
  String parking_pwd_location(Object location);

  /// No description provided for @closest_facilities.
  ///
  /// In pl, this message translates to:
  /// **'Najbliższe sąsiednie budynki i obiekty kampusu to: {places}'**
  String closest_facilities(Object places);

  /// No description provided for @digital_guide_website.
  ///
  /// In pl, this message translates to:
  /// **'www.przewodnik.pwr.edu.pl'**
  String get digital_guide_website;

  /// No description provided for @sks_old_menu.
  ///
  /// In pl, this message translates to:
  /// **'Zobacz ostatnie menu'**
  String get sks_old_menu;

  /// No description provided for @sks_menu_closed.
  ///
  /// In pl, this message translates to:
  /// **'SKS Menu jest teraz niedostępne'**
  String get sks_menu_closed;

  /// No description provided for @sks_show_last_menu.
  ///
  /// In pl, this message translates to:
  /// **'Pokaż ostatnio dostępne menu'**
  String get sks_show_last_menu;

  /// No description provided for @confirm.
  ///
  /// In pl, this message translates to:
  /// **'Zatwierdź'**
  String get confirm;

  /// No description provided for @push_notifications_dialog_info.
  ///
  /// In pl, this message translates to:
  /// **'Obecnie nie korzystamy z powiadomień push, ale planujemy dodać je w przyszłości. Możesz wyrazić na nie zgodę już teraz.'**
  String get push_notifications_dialog_info;

  /// No description provided for @sks_menu_technical_info.
  ///
  /// In pl, this message translates to:
  /// **'KOMUNIKAT'**
  String get sks_menu_technical_info;

  /// No description provided for @sks_note.
  ///
  /// In pl, this message translates to:
  /// **'UWAGA'**
  String get sks_note;

  /// No description provided for @sks_menu_you_see_last_menu.
  ///
  /// In pl, this message translates to:
  /// **'Aktualne menu SKS jest niedostępne. Przeglądasz ostatnio dostępną wersję.'**
  String get sks_menu_you_see_last_menu;

  /// An error message with a single parameter
  ///
  /// In pl, this message translates to:
  /// **'Wystąpił błąd podczas pobierania danych dotyczących {data_type}'**
  String my_offline_error_message(String data_type);

  /// No description provided for @measured_number_of_users.
  ///
  /// In pl, this message translates to:
  /// **'Zmierzona liczba użytkowników'**
  String get measured_number_of_users;

  /// No description provided for @forecasted_number_of_users.
  ///
  /// In pl, this message translates to:
  /// **'Średnia liczba użytkowników z ostatnich 21 dni'**
  String get forecasted_number_of_users;

  /// No description provided for @sks_chart_title.
  ///
  /// In pl, this message translates to:
  /// **'Przybliżona liczba osób w Strefie Kultury Studenckiej'**
  String get sks_chart_title;

  /// No description provided for @number_of_people.
  ///
  /// In pl, this message translates to:
  /// **'Liczba osób'**
  String get number_of_people;

  /// No description provided for @evacuation_text.
  ///
  /// In pl, this message translates to:
  /// **'Ewakuacja i pierwsza pomoc'**
  String get evacuation_text;

  /// No description provided for @digital_guide.
  ///
  /// In pl, this message translates to:
  /// **'Przewodnik'**
  String get digital_guide;

  /// Adapted toilet needs authorization with ending from API
  ///
  /// In pl, this message translates to:
  /// **'Toaleta jest dostępna wyłącznie dla osób uprawnionych. {comment}'**
  String adapted_toilet_authorization(String comment);

  /// No description provided for @adapted_toilet_no_authorization.
  ///
  /// In pl, this message translates to:
  /// **'Wejście do toalety nie wymaga żadnych specjalnych uprawnień.'**
  String get adapted_toilet_no_authorization;

  /// Adapted toilet is graphically marked info with ending from API
  ///
  /// In pl, this message translates to:
  /// **'Wejście do toalety jest dobrze oznakowane graficznie, za pomocą: {comment}'**
  String adapted_toilet_graphically_marked(String comment);

  /// No description provided for @adapted_toilet_not_graphically_marked.
  ///
  /// In pl, this message translates to:
  /// **'Wejście do toalety nie jest oznakowane graficznie.'**
  String get adapted_toilet_not_graphically_marked;

  /// Adapted toilet is marked info with ending from API
  ///
  /// In pl, this message translates to:
  /// **'Lokalizacja toalety jest oznaczona za pomocą informacji kierunkowej. {comment}'**
  String adapted_toilet_is_marked(String comment);

  /// No description provided for @adapted_toilet_is_not_marked.
  ///
  /// In pl, this message translates to:
  /// **'Lokalizacja toalety nie jest oznaczona za pomocą informacji kierunkowej.'**
  String get adapted_toilet_is_not_marked;

  /// No description provided for @images.
  ///
  /// In pl, this message translates to:
  /// **'Zdjęcia'**
  String get images;

  /// No description provided for @doors.
  ///
  /// In pl, this message translates to:
  /// **'Drzwi'**
  String get doors;

  /// No description provided for @accessibility_profile.
  ///
  /// In pl, this message translates to:
  /// **'Profil dostępności'**
  String get accessibility_profile;

  /// No description provided for @accessibility_profile_empty.
  ///
  /// In pl, this message translates to:
  /// **'Brak informacji dotyczących wybranego profilu dostępności'**
  String get accessibility_profile_empty;

  /// No description provided for @accessibility_card_information.
  ///
  /// In pl, this message translates to:
  /// **'{message} jest {accessibility_level} dla osób {disability_description}'**
  String accessibility_card_information(String message,
      String accessibility_level, String disability_description);

  /// No description provided for @accessibility_level_feminine.
  ///
  /// In pl, this message translates to:
  /// **'{level, select, 0{niedostępna} 1{niedostępna} 2{częściowo dostępna} 3{dostępna} other{niedostępna}}'**
  String accessibility_level_feminine(String level);

  /// No description provided for @accessibility_level_masculine.
  ///
  /// In pl, this message translates to:
  /// **'{level, select, 0{niedostępny} 1{niedostępny} 2{częściowo dostępny} 3{dostępny} other{niedostępny}}'**
  String accessibility_level_masculine(String level);

  /// No description provided for @accessibility_level_neuter.
  ///
  /// In pl, this message translates to:
  /// **'{level, select, 0{niedostępne} 1{niedostępne} 2{częściowo dostępne} 3{dostępne} other{niedostępne}}'**
  String accessibility_level_neuter(String level);

  /// No description provided for @people_with_cognitive_difficulties.
  ///
  /// In pl, this message translates to:
  /// **'posiadających trudności poznawcze'**
  String get people_with_cognitive_difficulties;

  /// No description provided for @people_with_hard_of_hearing.
  ///
  /// In pl, this message translates to:
  /// **'posiadających trudności ze słyszeniem'**
  String get people_with_hard_of_hearing;

  /// No description provided for @people_visually_impaired.
  ///
  /// In pl, this message translates to:
  /// **'słabo widzących'**
  String get people_visually_impaired;

  /// No description provided for @people_blind.
  ///
  /// In pl, this message translates to:
  /// **'niewidomych'**
  String get people_blind;

  /// No description provided for @people_with_motor_disability.
  ///
  /// In pl, this message translates to:
  /// **'posiadających dysfunkcje ruchu'**
  String get people_with_motor_disability;

  /// No description provided for @people_with_high_sensory_sensitivity.
  ///
  /// In pl, this message translates to:
  /// **'o wysokiej wrażliwości sensorycznej'**
  String get people_with_high_sensory_sensitivity;

  /// No description provided for @see_all_photos.
  ///
  /// In pl, this message translates to:
  /// **'Zobacz {photos, plural, =0{{photos} zdjęć} =1{{photos} zdjęcie} few{wszystkie {photos} zdjęcia} other{wszystkie {photos} zdjęć}}'**
  String see_all_photos(num photos);

  /// No description provided for @are_dangerous_elements_comment_prefix.
  ///
  /// In pl, this message translates to:
  /// **'W otoczeniu budynku znajdują się następujące obiekty, które mogą stanowić zagrożenie: {text}'**
  String are_dangerous_elements_comment_prefix(Object text);

  /// No description provided for @are_high_curbs_at_parking_space_for_pwd.
  ///
  /// In pl, this message translates to:
  /// **'Przy miejscach postojowych dla osób z niepełnosprawnościami {value, select, false{nie} other{}} znajduje się wysoki krawężnik. '**
  String are_high_curbs_at_parking_space_for_pwd(String value);

  /// No description provided for @is_lit.
  ///
  /// In pl, this message translates to:
  /// **'Otoczenie budynku {value, select, false{nie} other{}} jest oświetlone po zmroku. '**
  String is_lit(String value);

  /// No description provided for @is_pavement_rough.
  ///
  /// In pl, this message translates to:
  /// **'Nawierzchnia przy budynku {value, select, false{nie} other{}} jest równa. '**
  String is_pavement_rough(String value);

  /// No description provided for @are_lowered_curbs.
  ///
  /// In pl, this message translates to:
  /// **'Krawężniki w okolicach budynku {value, select, false{nie} other{}} są obniżone. '**
  String are_lowered_curbs(String value);

  /// No description provided for @are_no_barriers.
  ///
  /// In pl, this message translates to:
  /// **'Wokół budynku {value, select, true{nie ma barier uniemożliwiających dojścia} false{znajdują się bariery uniemożliwiające dojście} other{}} do budynku. '**
  String are_no_barriers(String value);

  /// No description provided for @is_path_to_accessible_entrance_marked.
  ///
  /// In pl, this message translates to:
  /// **'Ścieżka do wejścia dostępnego dla osób z niepełnosprawnościami {value, select, false{nie} other{}} jest wyraźnie oznaczona. '**
  String is_path_to_accessible_entrance_marked(String value);

  /// No description provided for @is_noisy_street_near_building.
  ///
  /// In pl, this message translates to:
  /// **'W okolicy {value, select, false{nie ma ruchliwej, hałaśliwej ulicy. } true{znajduje się ruchliwa, hałaśliwa ulica. } other{}}'**
  String is_noisy_street_near_building(String value);

  /// No description provided for @strategicBadgeTooltip.
  ///
  /// In pl, this message translates to:
  /// **'Koło Strategiczne PWr'**
  String get strategicBadgeTooltip;

  /// No description provided for @strategic_club_abbr.
  ///
  /// In pl, this message translates to:
  /// **'KS'**
  String get strategic_club_abbr;

  /// No description provided for @emptySection.
  ///
  /// In pl, this message translates to:
  /// **'Brak członków zespołu w tej wersji'**
  String get emptySection;

  /// No description provided for @digital_guide_offline.
  ///
  /// In pl, this message translates to:
  /// **'Cyfrowego Przewodnika'**
  String get digital_guide_offline;

  /// No description provided for @communique.
  ///
  /// In pl, this message translates to:
  /// **'Komunikat'**
  String get communique;

  /// No description provided for @audio_message.
  ///
  /// In pl, this message translates to:
  /// **'Komunikat Dźwiękowy'**
  String get audio_message;

  /// No description provided for @audio_message_comment.
  ///
  /// In pl, this message translates to:
  /// **'Sygnał znacznika może różnić się tempem i brzmieniem'**
  String get audio_message_comment;

  /// No description provided for @platforms.
  ///
  /// In pl, this message translates to:
  /// **'Podesty'**
  String get platforms;

  /// No description provided for @stairs.
  ///
  /// In pl, this message translates to:
  /// **'Schody'**
  String get stairs;

  /// No description provided for @key_information.
  ///
  /// In pl, this message translates to:
  /// **'Najważniejsze informacje'**
  String get key_information;

  /// No description provided for @working_hours.
  ///
  /// In pl, this message translates to:
  /// **'Godziny otwarcia'**
  String get working_hours;

  /// No description provided for @motorImpairment.
  ///
  /// In pl, this message translates to:
  /// **'Dysfunkcja ruchu'**
  String get motorImpairment;

  /// No description provided for @visualImpairment.
  ///
  /// In pl, this message translates to:
  /// **'Dysfunkcja wzroku'**
  String get visualImpairment;

  /// No description provided for @blind.
  ///
  /// In pl, this message translates to:
  /// **'Niewidomy'**
  String get blind;

  /// No description provided for @lowVision.
  ///
  /// In pl, this message translates to:
  /// **'Słabo widzący'**
  String get lowVision;

  /// No description provided for @sensorySensitivity.
  ///
  /// In pl, this message translates to:
  /// **'Wrażliwość sensoryczna'**
  String get sensorySensitivity;

  /// No description provided for @cognitiveImpairment.
  ///
  /// In pl, this message translates to:
  /// **'Trudności poznawcze'**
  String get cognitiveImpairment;

  /// No description provided for @accessibility_profiles.
  ///
  /// In pl, this message translates to:
  /// **'Profile dostępności'**
  String get accessibility_profiles;

  /// No description provided for @you_can_adjust.
  ///
  /// In pl, this message translates to:
  /// **'Możesz dostosować informacje pod swoje specjalne potrzeby'**
  String get you_can_adjust;

  /// No description provided for @additional_information.
  ///
  /// In pl, this message translates to:
  /// **'Dodatkowe informacje'**
  String get additional_information;

  /// No description provided for @lodge.
  ///
  /// In pl, this message translates to:
  /// **'Portiernia'**
  String get lodge;

  /// No description provided for @dressing_room.
  ///
  /// In pl, this message translates to:
  /// **'Szatnia'**
  String get dressing_room;

  /// No description provided for @no_lodge_in_the_building.
  ///
  /// In pl, this message translates to:
  /// **'W tym budynku nie ma portierni'**
  String get no_lodge_in_the_building;

  /// No description provided for @no_dressing_room_in_the_building.
  ///
  /// In pl, this message translates to:
  /// **'W tym budynku nie ma szatni'**
  String get no_dressing_room_in_the_building;

  /// No description provided for @general_offline.
  ///
  /// In pl, this message translates to:
  /// **'pobierania danych'**
  String get general_offline;

  /// No description provided for @floors_served_by_lift.
  ///
  /// In pl, this message translates to:
  /// **'Piętra obsługiwane przez windę'**
  String get floors_served_by_lift;

  /// No description provided for @dimensions.
  ///
  /// In pl, this message translates to:
  /// **'Wymiary'**
  String get dimensions;

  /// No description provided for @max_capacity.
  ///
  /// In pl, this message translates to:
  /// **'Maksymalny udźwig'**
  String get max_capacity;

  /// No description provided for @generic_error_message.
  ///
  /// In pl, this message translates to:
  /// **'Upsss...Coś poszło nie tak'**
  String get generic_error_message;

  /// No description provided for @navigate_to_building.
  ///
  /// In pl, this message translates to:
  /// **'Nawiguj do budynku'**
  String get navigate_to_building;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['pl'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'pl':
      return AppLocalizationsPl();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
