import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../../config/ui_config.dart";
import "../../../../theme/app_theme.dart";
import "../../../sks_chart/presentation/sks_chart_screen.dart";
import "../../data/models/sks_user_data.dart";
import "../../data/repository/latest_sks_user_data_repo.dart";

class SksUserDataButton extends ConsumerWidget {
  const SksUserDataButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncSksUserData = ref.watch(getLatestSksUserDataProvider);

    return asyncSksUserData.when(
      data: (sksUsersData) => _SksButton(
        sksUsersData,
        onTap: () async => showModalBottomSheet(
          context: context,
          constraints: BoxConstraints(
            maxHeight: MediaQuery.sizeOf(context).height *
                FilterConfig.bottomSheetHeightFactor,
          ),
          isScrollControlled: true,
          builder: (BuildContext context) => UncontrolledProviderScope(
            container: ProviderScope.containerOf(context),
            child: const SksChartView(),
          ),
        ),
      ),
      error: (error, stackTrace) => const SizedBox.shrink(),
      loading: () => const SizedBox.shrink(),
    );
  }
}

class _SksButton extends StatelessWidget {
  const _SksButton(this.sksUserData, {required this.onTap});

  final VoidCallback onTap;
  final SksUserData sksUserData;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: SksConfig.outerPadding,
      child: GestureDetector(
        onTap: onTap,
        child: Row(
          children: [
            Container(
              padding: SksConfig.innerPadding,
              decoration: BoxDecoration(
                border: Border.all(
                  color: context.colorTheme.orangePomegranade,
                ),
                borderRadius: BorderRadius.circular(SksConfig.radius),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.supervised_user_circle,
                    color: context.colorTheme.orangePomegranade,
                  ),
                  const SizedBox(
                    width: SksConfig.sizedBoxWidth,
                  ),
                  Text(
                    sksUserData.activeUsers.toString(),
                    style: context.textTheme.titleOrange,
                  ),
                  const SizedBox(
                    width: SksConfig.sizedBoxWidth,
                  ),
                  sksUserData.trend.icon,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

extension TrendIcon on Trend {
  Icon get icon {
    switch (this) {
      case Trend.increasing:
        return const Icon(Icons.trending_up, color: Color(0xFF28a745));
      case Trend.decreasing:
        return const Icon(Icons.trending_down, color: Color(0xFFdc3545));
      case Trend.stable:
        return const Icon(Icons.trending_flat, color: Colors.grey);
    }
  }
}
