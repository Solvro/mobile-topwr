import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../repositories/study_circles_repository/study_circles_repository.dart';
import 'news_and_study_circles_row_item.dart';
import '../../../theme/app_theme.dart';
import '../../../utils/context_extensions.dart';
import 'package:logger/logger.dart';

class StudyCirclesSection extends ConsumerWidget {
  const StudyCirclesSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(studyCirclesRepositoryProvider);
    return switch (state) {
      AsyncLoading() => const SizedBox.shrink(),
      AsyncError(:final error) => Builder(builder: (context) {
          Logger().e('An error occurred in StudyCirclesSection $error');
          return const SizedBox.shrink();
        }),
      AsyncValue(:final value) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(24.0, 16.0, 24.0, 4.0),
              child: SizedBox(
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(context.localize!.study_circles,
                        style: context.textTheme.headline),
                    TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                        ),
                        child: Text(context.localize!.see_list,
                            style: context.textTheme.boldBodyOrange))
                  ],
                ),
              ),
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
                              title: value[index]?.name ?? "",
                              shortDescription: value[index]?.description ?? "",
                              photoUrl: value[index]?.photo?.previewUrl ?? "",
                              onClick: (String id) {},
                            ),
                          ));
                    }))
          ],
        )
    };
  }
}
