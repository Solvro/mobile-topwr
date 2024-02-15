import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../config.dart';
import '../../../widgets/big_preview_card.dart';
import '../../../utils/context_extensions.dart';
import '../../../widgets/my_error_widget.dart';
import '../../../widgets/shimmer_loading.dart';
import '../../../widgets/subsection_header.dart';
import '../repositories/infos_repository/infos_preview_repository.dart';

class NewsSection extends StatelessWidget {
  const NewsSection({super.key});

  @override
  Widget build(BuildContext context) => Column(
        children: [
          SubsectionHeader(
              title: context.localize!.whats_up, onClick: () => {}),
          const _NewsList()
        ],
      );
}

class _NewsList extends ConsumerWidget {
  const _NewsList();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(infosPreviewRepositoryProvider);
    return switch (state) {
      AsyncLoading() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ShimmeringEffect(
            child: Container(
              width: double.maxFinite,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
              ),
            )),
      ),
      AsyncError(:final error) =>
        MyErrorWidget(NewsSectionConfig.errorMsg + error.toString()),
      AsyncValue(:final value) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 6, top: 16),
              child: SizedBox(
                  height: BigPreviewCardConfig.cardHeight,
                  child: ListView.builder(
                      cacheExtent: 4,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: value?.length ?? 0,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: value == null
                              ? const MyErrorWidget(NewsSectionConfig.errorMsg)
                              : BigPreviewCard(
                                  title: value[index]?.title ?? "",
                                  shortDescription:
                                      value[index]?.shortDescription ?? "",
                                  photoUrl: value[index]?.photo?.previewUrl,
                                  date: value[index]?.published_at,
                                  onClick: () {},
                                ),
                        );
                      })),
            )
          ],
        )
    };
  }
}
