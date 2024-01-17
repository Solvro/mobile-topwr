import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../widgets/loading_widget.dart';
import '../repositories/study_circles_repository/study_circles_repository.dart';
import '../../../widgets/big_preview_card.dart';
import '../../../theme/app_theme.dart';
import '../../../utils/context_extensions.dart';

class StudyCirclesSection extends ConsumerWidget {
  const StudyCirclesSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(studyCirclesRepositoryProvider);
    return switch (state) {
      AsyncLoading() => const LoadingWidget(),
      AsyncError(:final error) =>
        ErrorWidget('An error occurred in StudyCirclesSection $error'),
      AsyncValue(:final value) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _SubsectionHeader(),
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
                        padding: const EdgeInsets.only(
                            top: 8.0, right: 16.0, bottom: 8.0),
                        child: value == null
                            ? ErrorWidget(
                                "An error occurred in StudyCirclesSection's scrollable row")
                            : BigPreviewCard(
                                title: value[index]?.name ?? "",
                                shortDescription:
                                    value[index]?.description ?? "",
                                photoUrl: value[index]?.photo?.previewUrl ?? "",
                                onClick: () {},
                              ),
                      );
                    }))
          ],
        )
    };
  }
}

class _SubsectionHeader extends StatelessWidget {
  const _SubsectionHeader();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          left: 24.0, top: 16.0, right: 24.0, bottom: 4.0),
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
                child: Text(
                  context.localize!.see_list,
                  style: context.textTheme.boldBodyOrange,
                ))
          ],
        ),
      ),
    );
  }
}
