import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../api_base/directus_assets_url.dart";
import "../../config/ui_config.dart";
import "../../theme/app_theme.dart";
import "../../utils/context_extensions.dart";
import "../../widgets/detail_views/detail_view_app_bar.dart";
import "../../widgets/detail_views/sliver_header_section.dart";
import "../../widgets/my_error_widget.dart";
import "repository/about_us_repository.dart";
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
      AsyncLoading() => Center(
          child: CircularProgressIndicator(
            color: context.colorTheme.orangePomegranade,
          ),
        ),
      AsyncError(:final error) => MyErrorWidget(error),
      AsyncValue(:final value) => CustomScrollView(
          slivers: [
            SliverPersistentHeader(
              delegate: SliverHeaderSection(
                logoImageUrl: AboutUsConfig.defaultLogoUrl,
                backgroundImageUrl:
                    value?.aboutUs?.cover?.filename_disk?.directusUrl,
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  SectionHeader(text: context.localize.about_us),
                  DescriptionSection(text: value?.aboutUs?.description ?? ""),
                  SectionHeader(text: context.localize.meet_our_team),
                  TeamSection(
                    members: value?.getMemberData() ?? [],
                  ),
                  SectionHeader(text: context.localize.follow_solvro),
                  ContactSection(
                    links: value?.getSocialIcons() ?? [],
                  ),
                  const SizedBox(
                    height: AboutUsConfig.spacerHeight,
                  ),
                ],
              ),
            ),
          ],
        ),
    };
  }
}
