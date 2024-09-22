import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../config/ui_config.dart";
import "../../utils/context_extensions.dart";
import "../../widgets/detail_views/detail_view_app_bar.dart";
import "../../widgets/detail_views/sliver_header_section.dart";
import "../../widgets/loading_widgets/shimmer_loading.dart";
import "../../widgets/my_error_widget.dart";
import "models/about_us_details.dart";
import "repository/about_us_repository.dart";
import "widgets/app_version.dart";
import "widgets/contact_section.dart";
import "widgets/description_section.dart";
import "widgets/section_header.dart";
import "widgets/team_section.dart";

@RoutePage()
class AboutUsView extends StatelessWidget {
  const AboutUsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DetailViewAppBar(context, title: context.localize.guide),
      body: const _AboutUsView(),
    );
  }
}

class _AboutUsView extends ConsumerWidget {
  const _AboutUsView();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(aboutUsRepositoryProvider);
    return switch (state) {
      AsyncError(:final error) => MyErrorWidget(error),
      AsyncValue(:final AboutUsDetails value) => CustomScrollView(
          slivers: [
            SliverPersistentHeader(
              delegate: SliverHeaderSection(
                logoDirectusImageUrl: AboutUsConfig.defaultLogoUrl,
                backgroundImageUrl: value.aboutUs?.cover?.filename_disk,
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  SectionHeader(text: context.localize.about_us),
                  DescriptionSection(text: value.aboutUs?.description ?? ""),
                  SectionHeader(text: context.localize.meet_our_team),
                  TeamSection(
                    members: value.getMemberData(),
                  ),
                  SectionHeader(text: context.localize.follow_solvro),
                  ContactSection(
                    links: value.getSocialIcons(),
                  ),
                  const AppVersionTile(),
                ],
              ),
            ),
          ],
        ),
      _ => const _AboustUsLoading(),
    };
  }
}

class _AboustUsLoading extends StatelessWidget {
  const _AboustUsLoading();

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      linearGradient: shimmerGradient,
      child: ListView(
        physics: const NeverScrollableScrollPhysics(),
        children: [
          ShimmerLoadingItem(
            child: Container(
              color: Colors.white,
              width: double.infinity,
              height: 300,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(AboutUsConfig.defaultPadding),
            child: ShimmerLoadingItem(
              child: Container(
                width: double.infinity,
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.circular(AboutUsConfig.borderRadius),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(AboutUsConfig.defaultPadding),
            child: ShimmerLoadingItem(
              child: ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, _) {
                  return ShimmerLoadingItem(
                    child: Container(
                      width: double.infinity,
                      height: AboutUsConfig.photoSize,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.circular(AboutUsConfig.borderRadius),
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, _) => const SizedBox(
                  height: 8,
                ),
                itemCount: 3,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
