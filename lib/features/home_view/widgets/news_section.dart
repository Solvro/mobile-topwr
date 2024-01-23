import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../config.dart';
import '../../../widgets/loading_widget.dart';
import '../../../widgets/big_preview_card.dart';
import '../../../theme/app_theme.dart';
import '../../../utils/context_extensions.dart';
import '../../../widgets/my_error_widget.dart';
import '../repositories/infos_repository/infos_preview_repository.dart';

class NewsSection extends ConsumerWidget {
  const NewsSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(infosPreviewRepositoryProvider);
    return switch (state) {
      AsyncLoading() => const LoadingWidget(),
      AsyncError(:final error) =>
          MyErrorWidget(NewsSectionConfig.errorMsg + error.toString()),
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
                  height: BigPreviewCardConfig.cardHeight,
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
                      }))
            ],
          )
    };
  }
}
