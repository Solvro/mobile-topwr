import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../theme/app_theme.dart";
import "../models/sks_user_data.dart";
import "../repository/latest_sks_user_data_repo.dart";

class SksUserDataButton extends ConsumerWidget {
  const SksUserDataButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncSksUserData = ref.watch(getLatestSksUserDataProvider);

    return asyncSksUserData.when(
      data: _SksButton.new,
      error: (error, stackTrace) => const SizedBox.shrink(),
      loading: () => const SizedBox.shrink(),
    );
  }
}

class _SksButton extends StatelessWidget {
  const _SksButton(this.sksUserData, {super.key});

  final SksUserData sksUserData;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 12, bottom: 2),
      child: GestureDetector(
        onTap: () {},
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                border: Border.all(
                  color: context.colorTheme.orangePomegranade,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.supervised_user_circle,
                    color: context.colorTheme.orangePomegranade,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    sksUserData.activeUsers.toString(),
                    style: context.textTheme.titleOrange,
                  ),
                  const SizedBox(
                    width: 5,
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
