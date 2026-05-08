import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/widgets.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:topwr/features/sks/sks_chart/data/models/sks_chart_data.dart";
import "package:topwr/features/sks/sks_chart/data/repository/sks_chart_repository.dart";
import "package:topwr/features/sks/sks_chart/presentation/sks_chart_sheet.dart";
import "package:topwr/features/sks/sks_people_live/data/models/sks_user_data.dart";
import "package:topwr/features/sks/sks_people_live/data/repository/latest_sks_user_data_repo.dart";
import "package:widgetbook/widgetbook.dart";

part "sks_chart_sheet.stories.g.dart";

const meta = Meta<SksChartSheet>();

final _mockChartData = IList<SksChartData>([
  SksChartData(activeUsers: 120, movingAverage21: 110, externalTimestamp: DateTime(2026, 5, 8, 8)),
  SksChartData(activeUsers: 160, movingAverage21: 130, externalTimestamp: DateTime(2026, 5, 8, 10)),
  SksChartData(activeUsers: 190, movingAverage21: 150, externalTimestamp: DateTime(2026, 5, 8, 12)),
  SksChartData(activeUsers: 210, movingAverage21: 170, externalTimestamp: DateTime(2026, 5, 8, 14)),
]);

final _mockCurrentData = SksUserData(
  activeUsers: 210,
  movingAverage21: 170,
  externalTimestamp: DateTime(2026, 5, 8, 14),
  createdAt: DateTime(2026, 5, 8, 14),
  updatedAt: DateTime(2026, 5, 8, 14),
  trend: Trend.increasing,
  isResultRecent: true,
  nextUpdateTimestamp: DateTime(2026, 5, 8, 14, 10),
);

final $default = SksChartSheetStory(
  setup: (context, child, args) => ProviderScope(
    overrides: [
      sksChartRepositoryProvider.overrideWith((ref) => _mockChartData),
      getLatestSksUserDataProvider.overrideWith((ref) => _mockCurrentData),
    ],
    child: child,
  ),
);
