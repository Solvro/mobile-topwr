import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'news_and_study_circles_row_item.dart';
import '../../../theme/app_theme.dart';
import '../../../utils/context_extensions.dart';
import '../repositories/infos_repository/infos_preview_repository.dart';
import 'package:logger/logger.dart';

class NewsSection extends ConsumerWidget {
  const NewsSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(infosPreviewRepositoryProvider);
    return switch (state) {
      AsyncLoading() => const SizedBox.shrink(),
      AsyncError(:final error) => Builder(builder: (context) {
          Logger().e('An error occurred in NewsSection $error');
          return const SizedBox.shrink();
        }),
      AsyncValue(:final value) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(24.0, 16.0, 24.0, 4.0),
              child: Text(context.localize!.whats_up,
                  style: context.textTheme.headline),
            ),
            SizedBox(
                height: 360,
                child: ListView.builder(
                    padding: const EdgeInsets.fromLTRB(24, 0, 0, 0),
                    cacheExtent: 4,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: value?.length ?? 0,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                          padding:
                              const EdgeInsets.fromLTRB(0.0, 8.0, 16.0, 8.0),
                          child: Visibility(
                            visible: value != null,
                            child: ScrollableRowItem(
                              id: value![index]?.id ?? "",
                              title: value[index]?.title ?? "",
                              shortDescription:
                                  value[index]?.shortDescription ?? "",
                              photoUrl: value[index]?.photo?.previewUrl ?? "",
                              date: DateFormat('dd.MM.yyyy').format(
                                  value[index]?.published_at ?? DateTime.now()),
                              onClick: (String id) {},
                            ),
                          ));
                    }))
          ],
        )
    };
  }
}
