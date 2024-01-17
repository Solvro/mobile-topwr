import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../config.dart';
import '../../../widgets/loading_widget.dart';
import '../../../widgets/big_preview_card.dart';
import '../../../theme/app_theme.dart';
import '../../../utils/context_extensions.dart';
import '../repositories/infos_repository/infos_preview_repository.dart';

class NewsSection extends ConsumerWidget {
  const NewsSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(infosPreviewRepositoryProvider);
    return switch (state) {
      AsyncLoading() => const LoadingWidget(),
      AsyncError(:final error) =>
          ErrorWidget('An error occurred in NewsSection $error'),
      AsyncValue(:final value) =>
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:  const EdgeInsets.only(left: 24, top:16, right: 24, bottom: 4),
                child: Text(context.localize!.whats_up,
                    style: context.textTheme.headline),
              ),
              SizedBox(
                  height: 360,
                  child: ListView.builder(
                      padding: const EdgeInsets.only(left: 24),
                      cacheExtent: 4,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: value?.length ?? 0,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding:
                          const EdgeInsets.only(top : 8.0, right : 16.0, bottom : 8.0),
                          child: value == null
                              ? ErrorWidget("An error occurred in NewsSection's scrollable row")
                              : BigPreviewCard(
                            title: value[index]?.title ?? "",
                            shortDescription:
                            value[index]?.shortDescription ?? "",
                            photoUrl: value[index]?.photo?.previewUrl ?? "",
                            date: DateFormat(HomeNewsSubsectionConfig.dateTimeFormat).format(
                                value[index]?.published_at ?? DateTime.now()),
                            onClick: () {},
                          ),
                        );
                      }))
            ],
          )
    };
  }
}
