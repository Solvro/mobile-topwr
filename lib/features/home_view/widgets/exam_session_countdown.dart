import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:topwr/config.dart';
import 'package:topwr/theme/app_theme.dart';
import 'package:topwr/theme/hex_color.dart';

import '../repositories/exam_date_repository.dart';
import '../../../theme/colors.dart';

// ignore: must_be_immutable
class ExamSessionCountdown extends ConsumerWidget {
  ExamSessionCountdown({super.key});

  final DateTime today = DateTime.now();
  String timeDiff = '';
  String getNum(DateTime? examDate, int index) {
    if (timeDiff == '') {
      timeDiff = examDate!.difference(today).inDays.toString().padLeft(3, '0');
    }
    return timeDiff[index];
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(examSessionCountdownRepositoryProvider);
    return switch (state) {
      AsyncLoading() => const Center(
          child: CircularProgressIndicator(
            color: ColorsConsts.orangePomegranade,
          ),
        ),
      AsyncError(:final error) => Center(child: Text(error.toString())),
      AsyncValue(:final value) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Container(
            width: double.infinity,
            height: 69,
            decoration: BoxDecoration(
                gradient: ColorsConsts.toPwrGradient,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    spreadRadius: 6,
                    blurRadius: 11,
                    color: HexColor('#FA646529').withOpacity(.16),
                    offset: const Offset(0, 0),
                  ),
                ]),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      for (int i = 0; i < 3; i++)
                        IntBox(int: getNum(value!.endDate, i)),
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      ExamSessionCountdownConfig.daysString,
                      style: context.textTheme.headlineWhite,
                    ),
                    Text(
                      ExamSessionCountdownConfig.toStartSessionString,
                      style: context.textTheme.bodyWhite,
                    ),
                  ],
                ),
              ],
            ),
          ),
        )
    };
  }
}

class IntBox extends StatelessWidget {
  final String int;
  const IntBox({
    super.key,
    required this.int,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 4),
      width: 28,
      height: 37,
      decoration: BoxDecoration(
        color: context.colorTheme.whiteSoap,
        borderRadius: BorderRadius.circular(4),
        boxShadow: [
          BoxShadow(
            color: HexColor('#C62D2E66').withOpacity(.4),
            offset: const Offset(-1, 1),
            blurRadius: 4,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Center(
        child: Text(
          int.toString(),
          style: context.textTheme.headline,
        ),
      ),
    );
  }
}
