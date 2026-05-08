import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:topwr/features/about_us_view/data/repository/about_us_repository.dart";
import "package:topwr/features/academic_calendar/repository/academic_calendar_repo.dart";
import "package:topwr/features/app_streak/business/get_days_use_case.dart";
import "package:topwr/features/calendar/bussiness/get_events_per_days_use_case.dart";
import "package:topwr/features/departments/department_detail_view/data/repository/department_details_repository.dart";
import "package:topwr/features/departments/departments_view/data/repository/departments_repository.dart";
import "package:topwr/features/digital_guide/data/repository/digital_guide_repository.dart";
import "package:topwr/features/digital_guide/data/repository/image_repository.dart";
import "package:topwr/features/digital_guide_objects/data/repositories/digital_guide_object_repository.dart";
import "package:topwr/features/guide_detail_view/data/repository/guide_details_repository.dart";
import "package:topwr/features/guide_view/data/repository/guide_repository.dart";
import "package:topwr/features/multilayer_map/business/multilayer_source_service.dart";
import "package:topwr/features/newsfeed/data/repository/newsfeed_repository.dart";
import "package:topwr/features/notifications/data/models/notification_model.dart";
import "package:topwr/features/notifications/data/repository/notifications_repository.dart";
import "package:topwr/features/parkings/parking_chart/repository/chart_repository.dart";
import "package:topwr/features/parkings/parkings_view/repository/parkings_repository.dart";
import "package:topwr/features/planner_advert/repository/planner_advert_repository.dart";
import "package:topwr/features/radio_luz/data/repository/history_entry_repository.dart";
import "package:topwr/features/radio_luz/data/repository/schedule_repository.dart";
import "package:topwr/features/radio_luz/service/has_internet_connection.dart";
import "package:topwr/features/radio_luz/service/radio_player_controller.dart";
import "package:topwr/features/remote_config/data/repository/remote_config_repository.dart";
import "package:topwr/features/science_club/science_club_detail_view/repository/science_club_details_repository.dart";
import "package:topwr/features/science_club/science_clubs_filters/repository/tags_repository.dart";
import "package:topwr/features/science_club/science_clubs_view/repository/science_clubs_repository.dart";
import "package:topwr/features/sks/sks_chart/data/repository/sks_chart_repository.dart";
import "package:topwr/features/sks/sks_favourite_dishes/data/repository/sks_favourite_dishes_repository.dart";
import "package:topwr/features/sks/sks_menu/data/models/sks_menu_response.dart";
import "package:topwr/features/sks/sks_menu/data/repository/sks_menu_repository.dart";
import "package:topwr/features/sks/sks_people_live/data/repository/latest_sks_user_data_repo.dart";
import "package:topwr/theme/app_theme.dart";
import "package:widgetbook/widgetbook.dart";

import "components.g.dart";
import "map_config_story_wrapper.dart";
import "radio_luz_mocks.dart";
import "widgetbook_mocks.dart";

final config = Config(
  components: components,
  addons: [AlignmentAddon()],
  appBuilder: (context, child) {
    final fallbackAssetBundle = _TopwrFallbackAssetBundle(rootBundle);
    return ProviderScope(
      overrides: [
        academicCalendarRepoProvider.overrideWith((ref) => mockAcademicCalendarWithSwaps),
        aboutUsRepositoryProvider.overrideWith((ref) => mockAboutUs),
        departmentDetailsRepositoryProvider.overrideWith((ref, id) => mockDepartmentDetails),
        departmentsRepositoryProvider.overrideWith((ref) => mockDepartments),
        digitalGuideRepositoryProvider.overrideWith(
          (ref, ourId) => (digitalGuideData: mockDigitalGuideResponse, photoUrl: "", building: mockBuilding),
        ),
        imageRepositoryProvider.overrideWith(
          (ref, imageID) => Future.value("https://placehold.co/1200x800/png?text=Digital+Guide+Image+$imageID"),
        ),
        digitalGuideObjectRepositoryProvider.overrideWith(
          (ref, args) => (digitalGuideData: mockDigitalGuideObjectModel, photoUrl: ""),
        ),
        getLatestSksUserDataProvider.overrideWith((ref) => mockSksUserData),
        sksChartRepositoryProvider.overrideWith((ref) => mockSksChartData),
        getEventsPerDaysUseCaseProvider.overrideWith((ref) => mockCalendarYearEvents),
        guideRepositoryProvider.overrideWith((ref) => mockGuideArticles),
        guideDetailsRepositoryProvider.overrideWith((ref, id) => mockGuideDetails),
        hasInternetConnectionProvider.overrideWith((ref) => Stream.value(true)),
        historyEntryRepositoryProvider.overrideWith((ref) => Future.value(mockHistoryEntries)),
        getUsageDaysUseCaseProvider.overrideWith((ref) => Future.value(42)),
        multilayerSourceServiceProvider.overrideWith((ref) => mockMultilayerItems),
        newsfeedRepositoryProvider.overrideWith((ref) => mockNewsArticles),
        notificationsRepositoryProvider.overrideWith(WidgetbookNotificationsRepository.new),
        chartRepositoryProvider.overrideWith((ref, parking) => mockParkingChartData),
        parkingsRepositoryProvider.overrideWith((ref) => mockParkings),
        plannerAdvertContentRepositoryProvider.overrideWith((ref) => Future.value(mockPlannerBanner)),
        radioControllerProvider.overrideWith(FakeRadioController.new),
        remoteConfigRepositoryProvider.overrideWith((ref) => mockRemoteConfig),
        scheduleRepositoryProvider.overrideWith((ref) => Future.value(mockBroadcasts)),
        scienceClubDetailsRepositoryProvider.overrideWith((ref, id) => mockScienceClubDetails),
        scienceClubsRepositoryProvider.overrideWith((ref) => mockScienceClubs),
        sksFavouriteDishesRepositoryProvider.overrideWith(WidgetbookSksFavouriteDishesRepository.new),
        sksMenuRepositoryProvider.overrideWith(WidgetbookSksMenuRepository.new),
        tagsRepositoryProvider.overrideWith((ref) => mockScienceClubTags),
      ],
      child: DefaultAssetBundle(
        bundle: fallbackAssetBundle,
        child: Theme(
          data: const AppTheme().light,
          child: Material(child: widgetbookMapConfigWrapper(child)),
        ),
      ),
    );
  },
);

class _TopwrFallbackAssetBundle extends CachingAssetBundle {
  _TopwrFallbackAssetBundle(this._delegate);

  final AssetBundle _delegate;

  static const _topwrAssetsPackagePrefix = "packages/topwr_assets/";
  static const _legacyAssetsPrefix = "assets/";

  @override
  Future<ByteData> load(String key) async {
    try {
      return await _delegate.load(key);
    } catch (_) {
      if (key.startsWith(_topwrAssetsPackagePrefix)) rethrow;
      if (key.startsWith(_legacyAssetsPrefix)) {
        return _delegate.load("$_topwrAssetsPackagePrefix$key");
      }
      rethrow;
    }
  }

  @override
  Future<String> loadString(String key, {bool cache = true}) async {
    try {
      return await _delegate.loadString(key, cache: cache);
    } catch (_) {
      if (key.startsWith(_topwrAssetsPackagePrefix)) rethrow;
      if (key.startsWith(_legacyAssetsPrefix)) {
        return _delegate.loadString("$_topwrAssetsPackagePrefix$key", cache: cache);
      }
      rethrow;
    }
  }
}

class WidgetbookNotificationsRepository extends NotificationsRepository {
  @override
  Future<void> clearCache() async {}

  @override
  Future<IList<NotificationModel>> build() async => mockNotifications;
}

class WidgetbookSksMenuRepository extends SksMenuRepository {
  @override
  Future<void> clearCache() async {}

  @override
  Future<ExtendedSksMenuResponse> build() async => mockExtendedSksMenuResponse;
}

class WidgetbookSksFavouriteDishesRepository extends SksFavouriteDishesRepository {
  @override
  Future<void> clearCache() async {}

  @override
  Future<SksFavouriteDishesMap> build() async => mockSksFavouriteDishesMap;

  @override
  Future<bool> toggleDishSubscription(String dishId, {required bool isSubscribed}) async => true;
}
