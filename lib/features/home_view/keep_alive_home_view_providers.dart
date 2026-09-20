import "package:flutter/widgets.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../academic_calendar/repository/academic_calendar_repo.dart";
import "../app_streak/business/get_days_use_case.dart";
import "../newsfeed/data/repository/newsfeed_repository.dart";
import "../science_club/science_clubs_view/repository/science_clubs_repository.dart";
import "home_view.dart";

part "keep_alive_home_view_providers.g.dart";

/// A [Widget] that prevents the [HomeView] scrollable section to flicker when scrolling by keeping all states stable.
class KeepAliveHomeViewProviders extends ConsumerWidget {
  const KeepAliveHomeViewProviders({super.key, required this.child, required this.academicCalendarEnabled});
  final Widget child;
  final bool academicCalendarEnabled;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(keepAliveHomeViewProvidersProvider(academicCalendarEnabled: academicCalendarEnabled));
    return child;
  }
}

@riverpod
void keepAliveHomeViewProviders(Ref ref, {required bool academicCalendarEnabled}) {
  if (academicCalendarEnabled) ref.watch(academicCalendarRepoProvider);
  ref.watch(scienceClubsRepositoryProvider);
  ref.watch(getUsageDaysUseCaseProvider);
  ref.watch(newsfeedRepositoryProvider);
  return;
}
