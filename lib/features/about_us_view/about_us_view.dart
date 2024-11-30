import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../config/ui_config.dart";
import "../../utils/context_extensions.dart";
import "../../widgets/detail_views/detail_view_app_bar.dart";
import "../../widgets/detail_views/sliver_header_section.dart";
import "../../widgets/loading_widgets/scrolable_loader_builder.dart";
import "../../widgets/loading_widgets/simple_previews/preview_card_loading.dart";
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
      appBar: DetailViewAppBar(),
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
                  SectionHeader(text: context.localize.follow_solvro),
                  ContactSection(
                    links: value.getSocialIcons(),
                  ),
                  SectionHeader(text: context.localize.meet_our_team),
                  TeamSection(
                    members: value.getMemberData(),
                  ),
                  const AppVersionTile(),
                ],
              ),
            ),
          ],
        ),
      _ => const _AboutUsLoading(),
    };
  }
}

class _AboutUsLoading extends StatelessWidget {
  const _AboutUsLoading();

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const NeverScrollableScrollPhysics(),
      children: [
        const PreviewCardLoading(
          width: double.infinity,
          height: 300,
        ),
        const Padding(
          padding: EdgeInsets.all(AboutUsConfig.defaultPadding),
          child: PreviewCardLoading(
            width: double.infinity,
            height: 150,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(AboutUsConfig.defaultPadding),
          child: SizedBox(
            height: MediaQuery.of(context).size.height / 4,
            child: ScrollableLoaderBuilder(
              itemsSpacing: 8,
              scrollDirection: Axis.vertical,
              mainAxisItemSize: 16,
              itemBuilder: (BuildContext context, int index) {
                return const PreviewCardLoading(
                  width: double.infinity,
                  height: AboutUsConfig.photoSize,
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
